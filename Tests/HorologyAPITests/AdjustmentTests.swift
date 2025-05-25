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
struct AdjustmentTests {

    private let fromDate = Components.Schemas.DateFields(
        year: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.year.rawValue, value: 2023),
        month: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.month.rawValue, value: 10),
        day: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.day.rawValue, value: 1),
        hour: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.hour.rawValue, value: 7),
        minute: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.minute.rawValue, value: 0),
        second: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.second.rawValue, value: 0))
    private let adjustments = Components.Schemas.DateFields(
        year: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.year.rawValue, value: 1),
        month: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.month.rawValue, value: 0),
        day: Components.Schemas.DateTimeField(_type: DateTimeFieldType.day.rawValue, value: 0),
        hour: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.hour.rawValue, value: 0),
        minute: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.minute.rawValue, value: 0),
        second: Components.Schemas.DateTimeField(
            _type: DateTimeFieldType.second.rawValue, value: 0))

    @Test
    func testCalculate() async throws {

        let handler = HorologyService()
        let response = try await handler.adjust(
            body: .json(
                .init(
                    date: fromDate,
                    adjustments: adjustments, calendar: "gregorian",
                    mode: Components.Schemas.AdjustmentRequest.ModePayload.dateAndTime)))

        guard case .json(let resp) = try response.ok.body else {
            Issue.record("Unexpected response body")
            return
        }

        #expect(resp.date == "2024-10-01T07:00:00Z")
        #expect(resp.components.year == 2024)
        #expect(resp.components.month == 10)
        #expect(resp.components.day == 1)
        #expect(resp.components.hour == 7)
        #expect(resp.components.minute == 0)
        #expect(resp.components.second == 0)
    }

    @Test
    func testInvalidCalendarIdentifier() async throws {

        let handler = HorologyService()
        let response = try await handler.adjust(
            body: .json(
                .init(
                    date: fromDate,
                    adjustments: adjustments, calendar: "invalid",
                    mode: Components.Schemas.AdjustmentRequest.ModePayload.dateAndTime)))

        guard case .json(let resp) = try response.badRequest.body else {
            Issue.record("Response should have returned an error")
            return
        }

        #expect(resp.code == ErrorCodes.invalidCalendar.rawValue)
             #expect(resp.reason?.count ?? 0 > 0)
    }

    // @Test
    // func testCalculateInvalidMode() async throws {

    //     let handler = HorologyService()
    //     let response = try await handler.calculate(
    //         body: .json(
    //             .init(
    //                 date: fromDate,
    //                 adjustments: adjustments, calendar: "gregorian",
    //                 mode: "invalid")))

    //     guard case .json(let resp) = try response.badRequest.body else {
    //         Issue.record("Response should have returned an error")
    //         return
    //     }

    //     #expect(resp.code == ErrorCodes.invalidCalendar.rawValue)
    //     #expect(resp.reason == "")
    // }

}
