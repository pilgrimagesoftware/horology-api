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
struct CalculateControllerTests {

    private let fromDate = HorologyAPI.DateFields(
        year: DateTimeField(
            type: DateTimeFieldType.year.rawValue, value: 2023),
        month: DateTimeField(
            type: DateTimeFieldType.month.rawValue, value: 10),
        day: DateTimeField(
            type: DateTimeFieldType.day.rawValue, value: 1),
        hour: DateTimeField(
            type: DateTimeFieldType.hour.rawValue, value: 0),
        minute: DateTimeField(
            type: DateTimeFieldType.minute.rawValue, value: 0),
        second: DateTimeField(
            type: DateTimeFieldType.second.rawValue, value: 0))
    private let adjustments = HorologyAPI.DateFields(
        year: DateTimeField(
            type: DateTimeFieldType.year.rawValue, value: 1),
        month: DateTimeField(
            type: DateTimeFieldType.month.rawValue, value: 0),
        day: DateTimeField(type: DateTimeFieldType.day.rawValue, value: 0),
        hour: DateTimeField(
            type: DateTimeFieldType.hour.rawValue, value: 0),
        minute: DateTimeField(
            type: DateTimeFieldType.minute.rawValue, value: 0),
        second: DateTimeField(
            type: DateTimeFieldType.second.rawValue, value: 0))

    private func withApp(_ test: (Application) async throws -> Void) async throws {
        let app = try await Application.make(.testing)
        do {
            try await configure(app)
            try await test(app)
        } catch {
            try await app.asyncShutdown()
            throw error
        }
        try await app.asyncShutdown()
    }

    @Test
    func testCalculate() async throws {
        try await withApp { app in
            try await app.testing().test(
                .GET, "calculate",
                beforeRequest: { req in
                    try req.content.encode(
                        CalculationRequest(
                            date: fromDate,
                            adjustments: adjustments,
                            calendar: "gregorian",
                            mode: DateTimeMode.dateAndTime.rawValue))
                },
                afterResponse: { res async throws in
                    #expect(res.status == .ok)
                    #expect(res.headers.contentType == .json)
                    let resp = try res.content.decode(CalculationResponse.self)
                    #expect(resp.date == "2024-10-01T07:00:00Z")
                    #expect(resp.components.year == 2024)
                    #expect(resp.components.month == 10)
                    #expect(resp.components.day == 1)
                    #expect(resp.components.hour == 0)
                    #expect(resp.components.minute == 0)
                    #expect(resp.components.second == 0)
                })
        }
    }

    @Test
    func testInvalidCalendarIdentifier() async throws {
        try await withApp { app in
            try await app.testing().test(
                .GET, "calculate",
                beforeRequest: { req in
                    try req.content.encode(
                        CalculationRequest(
                            date: fromDate,
                            adjustments: adjustments,
                            calendar: "invalid_calendar",
                            mode: "dateAndTime"))
                },
                afterResponse: { res async throws in
                    #expect(res.status == .badRequest)
                    #expect(res.headers.contentType == .json)
                    let resp = try res.content.decode(ErrorResponse.self)
                    #expect(resp.error == true)
                    #expect(resp.reason == "Invalid calendar identifier")
                })
        }
    }

    @Test
    func testCalculateInvalidMode() async throws {
        try await withApp { app in
            try await app.testing().test(
                .GET, "calculate",
                beforeRequest: { req in
                    try req.content.encode(
                        CalculationRequest(
                            date: fromDate,
                            adjustments: adjustments,
                            calendar: "gregorian",
                            mode: "invalid_mode"))
                },
                afterResponse: { res async throws in
                    #expect(res.status == .badRequest)
                    #expect(res.headers.contentType == .json)
                    let resp = try res.content.decode(ErrorResponse.self)
                    #expect(resp.error == true)
                    #expect(resp.reason == "Invalid mode")
                })
        }
    }

}
