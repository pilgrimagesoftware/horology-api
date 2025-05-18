//
//  HorologyAPITests.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Testing
import VaporTesting

@testable import HorologyAPI

@Suite
struct ConvertControllerTests {

    // private func withApp(_ test: (Application) async throws -> Void) async throws {
    //     let app = try await Application.make(.testing)
    //     do {
    //         try await configure(app)
    //         try await test(app)
    //     } catch {
    //         try await app.asyncShutdown()
    //         throw error
    //     }
    //     try await app.asyncShutdown()
    // }

    // @Test
    // func testInvalidType() async throws {
    //     try await withApp { app in
    //         try await app.testing().test(
    //             .GET, "convert/invalid",
    //             afterResponse: { res async throws in
    //                 #expect(res.status == .badRequest)
    //                 #expect(res.headers.contentType == .json)
    //                 let resp = try res.content.decode(ErrorResponse.self)
    //                 #expect(resp.error == true)
    //                 #expect(resp.reason ==  "Invalid conversion type")
    //             })
    //     }
    // }

    // @Test
    // func testInvalidUnit() async throws {
    //     try await withApp { app in
    //         try await app.testing().test(
    //             .GET, "convert/years",
    //             beforeRequest: { req in
    //                 try req.content.encode(ConversionRequest(value: 1, unit: "invalid"))
    //             },
    //             afterResponse: { res async throws in
    //                 #expect(res.status == .badRequest)
    //                 #expect(res.headers.contentType == .json)
    //                 let resp = try res.content.decode(ErrorResponse.self)
    //                 #expect(resp.error == true)
    //                 #expect(resp.reason == "Invalid unit")
    //             })
    //     }
    // }

    @Test
    func testConvertToYears() async throws {

let handler = HorologyService()
// let response = try await handler.convert()


        // try await withApp { app in
        //     try await app.testing().test(
        //         .GET, "convert/years",
        //         beforeRequest: { req in
        //             try req.content.encode(ConversionRequest(value: 12, unit: "months"))
        //         },
        //         afterResponse: { res async throws in
        //             #expect(res.status == .ok)
        //             #expect(res.headers.contentType == .json)
        //             let resp = try res.content.decode(ConversionResponse.self)
        //             #expect(resp.value == 1)
        //             #expect(resp.approximate == false)
        //             #expect(resp.message == nil)
        //         })
        // }
    }

}
