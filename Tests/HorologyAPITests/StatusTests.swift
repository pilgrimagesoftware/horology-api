//
//  StatusTests.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Testing
import VaporTesting

@testable import HorologyAPI

@Suite
struct StatusTests {

    @Test
    func testStatus() async throws {
        let handler = HorologyService()
        let response = try await handler.status()
        #expect(try response.ok.body.json.date != nil)
        #expect(try response.ok.body.json.hostname != nil)
    }
}
