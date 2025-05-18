//
//  entrypoint.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Logging
import MetricsMiddleware
import NIO
import NIOCore
import NIOPosix
import OTLPGRPC
import OTel
import OpenAPIRuntime
import OpenAPIVapor
import Tracing
import TracingMiddleware
import LoggingMiddleware
import Vapor

@main
enum Entrypoint {
    static func main() async throws {
        var env = try Environment.detect()
        try LoggingSystem.bootstrap(from: &env)
        let logger = Logger(label: "com.pilgrimagesoftware.horology.api.HorologyAPI")

        let app = try await Application.make(env)
        let transport = VaporTransport(routesBuilder: app)

        let environment = OTelEnvironment.detected()
        let resourceDetection = OTelResourceDetection(detectors: [
            OTelProcessResourceDetector(),
            OTelEnvironmentResourceDetector(environment: environment),
        ])
        let resource = await resourceDetection.resource(environment: environment, logLevel: .trace)
        let exporter = try OTLPGRPCSpanExporter(configuration: .init(environment: environment))
        let processor = OTelBatchSpanProcessor(
            exporter: exporter, configuration: .init(environment: environment))
        let tracer = OTelTracer(
            idGenerator: OTelRandomIDGenerator(),
            sampler: OTelConstantSampler(isOn: true),
            propagator: OTelW3CPropagator(),
            processor: processor,
            environment: environment,
            resource: resource
        )
        InstrumentationSystem.bootstrap(tracer)

        // try await configure(app, transport)
        let handler = HorologyService()
        try handler.registerHandlers(
            on: transport,
            serverURL: URL(string: "/api")!,
            middlewares: [
                TracingMiddleware(),
                MetricsMiddleware(counterPrefix: "HorologyAPI"),
                LoggingMiddleware(logger: logger, bodyLoggingConfiguration: .upTo(maxBytes: 1024))
            ])

        app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

        app.get("openapi") { request in
            request.redirect(to: "openapi.html", redirectType: .permanent)
        }

        try await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask { try await app.execute() }
            group.addTask { try await tracer.run() }
            group.addTask { try await processor.run() }
            _ = try await group.next()
            group.cancelAll()
        }
    }
}
