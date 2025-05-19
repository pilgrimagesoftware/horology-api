//
//  HorologyService+Calculate.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation
import HorologyCore
import OpenAPIRuntime
import OpenAPIVapor
import Vapor

extension HorologyService {
    func calculate(_ input: Operations.Calculate.Input) async throws -> Operations.Calculate.Output {
        guard case .json(let body) = input.body
        else {
            return .badRequest(
                .init(
                    body: .json(
                        .init(
                            code: ErrorCodes.serialization.rawValue,
                            reason: "Request body could not be deserialized")))
            )
        }

        let calendar: Calendar
        do {
            calendar = try Calendar.from(identifier: body.calendar ?? "gregorian")
        } catch {
            // req.logger.error("Failed to create calendar: \(error)")
            return .badRequest(
                .init(
                    body: .json(
                        .init(
                            code: ErrorCodes.invalidCalendar.rawValue,
                            reason: "Invalid calendar identifier"))))
        }

        let startDate = makeDateFields(from: body.date)
        let adjustments = makeDateFields(from: body.adjustments)

        guard let mode = DateTimeMode(rawValue: body.mode.rawValue) else {
            throw Abort(.badRequest, reason: "Invalid mode")
        }

        let calculator = DateCalculator(
            startDate: startDate,
            adjustments: adjustments,
            calendar: calendar)
        let result = try calculator.calculateDate(with: mode)

        let response = Components.Schemas.CalculationResponse(
            date: result.formatted(.iso8601),
            components: makeContentFromDateComponents(
                calendar.dateComponents(
                    [.year, .month, .day, .hour, .minute, .second], from: result)))
        return .ok(.init(body: .json(response)))
    }
}
