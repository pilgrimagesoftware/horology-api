//
//  CalendarsTests.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Testing
import VaporTesting

@testable import HorologyAPI

@Suite
struct CalendarsTests {

    @Test
    func testCalendarList() async throws {
        let handler = HorologyService()
        let response = try await handler.getCalendars()
        #expect(try response.ok.body.json.count > 0)
    }

}
