// //
// //  HorologyAPITests.swift
// //  Horology API
// //  Copyright © 2025 Pilgrimage Software. All rights reserved.
// //

// import Testing
// import VaporTesting

// @testable import HorologyAPI

// @Suite
// struct CompareControllerTests {

//     private func withApp(_ test: (Application) async throws -> Void) async throws {
//         let app = try await Application.make(.testing)
//         do {
//             try await configure(app)
//             try await test(app)
//         } catch {
//             try await app.asyncShutdown()
//             throw error
//         }
//         try await app.asyncShutdown()
//     }

//      @Test
//     func testCompare() async throws {
//         // try await withApp { app in
//         //     try await app.testing().test(
//         //         .GET, "compare",
//         //         beforeRequest: { req in
//         //             try req.content.encode(ConversionRequest(value: 12, unit: "months"))
//         //         },
//         //         afterResponse: { res async throws in
//         //             #expect(res.status == .ok)
//         //             #expect(res.headers.contentType == .json)
//         //             let resp = try res.content.decode(ConversionResponse.self)
//         //             #expect(resp.value == 1)
//         //             #expect(resp.approximate == false)
//         //             #expect(resp.message == nil)
//         //         })
//         // }
//     }

//     @Test
//     func testInvalidCalendar() async throws {}

//     @Test
//     func testInvalidMode() async throws {}

//     @Test
//     func testInvalidFromDate() async throws {}

//     @Test
//     func testInvalidToDate() async throws {}

//     @Test
//     func testInvalidFromTime() async throws {}

//     @Test
//     func testInvalidToTime() async throws {}

// }
