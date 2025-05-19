//
//  HorologyAPITests.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import HorologyCore
import Testing
import VaporTesting

@testable import HorologyAPI

@Suite
struct CompareControllerTests {

    private let fromDate = Components.Schemas.DateFields(
        year: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.year.rawValue, value: 2023),
        month: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.month.rawValue, value: 10),
        day: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.day.rawValue, value: 1),
        hour: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.hour.rawValue, value: 0),
        minute: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.minute.rawValue, value: 0),
        second: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.second.rawValue, value: 0))
    private let toDate = Components.Schemas.DateFields(
        year: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.year.rawValue, value: 2024),
        month: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.month.rawValue, value: 11),
        day: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.day.rawValue, value: 1),
        hour: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.hour.rawValue, value: 0),
        minute: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.minute.rawValue, value: 0),
        second: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.second.rawValue, value: 0))

    @Test
    func testCompare() async throws {

        let handler = HorologyService()
        let response = try await handler.compare(
            body: .json(
                .init(
                    fromDate: fromDate,
                    toDate: toDate,
                    calendar: "gregorian",
                    mode: Components.Schemas.ComparisonRequest.ModePayload.dateAndTime)))

        guard case .json(let resp) = try response.ok.body else {
            Issue.record("Unexpected response body")
            return
        }

        #expect(resp.difference.year?.value == 1)
        #expect(resp.difference.month?.value == 1)
        #expect(resp.difference.day?.value == 0)
        #expect(resp.difference.hour?.value == 0)
        #expect(resp.difference.minute?.value == 1)
        #expect(resp.difference.second?.value == 0)
    }

    @Test
    func testInvalidCalendar() async throws {

        let handler = HorologyService()
        let response = try await handler.compare(
            body: .json(
                .init(
                    fromDate: fromDate,
                    toDate: toDate,
                    calendar: "gregorian",
                    mode: Components.Schemas.ComparisonRequest.ModePayload.dateAndTime)))

        guard case .json(let resp) = try response.badRequest.body else {
            Issue.record("Response should have returned an error")
            return
        }

        #expect(resp.code == ErrorCodes.invalidCalendar.rawValue)
        #expect(resp.reason == "")
    }

    @Test
    func testInvalidMode() async throws {}

    @Test
    func testInvalidFromDate() async throws {}

    @Test
    func testInvalidToDate() async throws {}

    @Test
    func testInvalidFromTime() async throws {}

    @Test
    func testInvalidToTime() async throws {}

}
