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

    @Test
    func testInvalidType() async throws {

        let handler = HorologyService()

        let response = try await handler.convert(
            path: .init(to: "invalid"),
            body: .json(.init(value: 1, unit: "months")))

        guard case .json(let resp) = try response.badRequest.body else {
            Issue.record("Response should have returned an error")
            return
        }

        #expect(resp.code == ErrorCodes.invalidUnit.rawValue)
        #expect(resp.reason == "Invalid unit to convert to")
    }

    @Test
    func testInvalidUnit() async throws {

        let handler = HorologyService()
        let response = try await handler.convert(
            path: .init(to: "years"),
            body: .json(.init(value: 1, unit: "invalid")))

        guard case .json(let resp) = try response.badRequest.body else {
            Issue.record("Response should have returned an error")
            return
        }

        #expect(resp.code == ErrorCodes.invalidUnit.rawValue)
        #expect(resp.reason == "Invalid unit to convert from")
    }

    @Test
    func testConvertToYears() async throws {

        let handler = HorologyService()
        let response = try await handler.convert(
            path: .init(to: "years"),
            body: .json(.init(value: 12, unit: "months")))

        guard case .json(let resp) = try response.ok.body else {
            Issue.record("Unexpected response body")
            return
        }

        #expect(resp.value == 1)
        #expect(resp.approximate == false)
    }

}
