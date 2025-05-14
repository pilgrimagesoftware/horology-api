//
//  HorologyAPITests.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

@testable import HorologyAPI
import VaporTesting
import Testing


@Suite("App Tests")
struct HorologyAPITests {
    private func withApp(_ test: (Application) async throws -> ()) async throws {
        let app = try await Application.make(.testing)
        do {
            try await configure(app)
            try await test(app)
        }
        catch {
            try await app.asyncShutdown()
            throw error
        }
        try await app.asyncShutdown()
    }

    @Test("Test convert to years")
    func convertToYears() async throws {
        // try await withApp { app in
        //     try await app.testing().test(.GET, "convert/years", afterResponse: { res async in
        //         #expect(res.status == .ok)
        //         #expect(res.body.string == "Hello, world!")
        //     })
        // }
    }
}
