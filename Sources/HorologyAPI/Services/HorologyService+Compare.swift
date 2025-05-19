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
    func compare(_ input: Operations.Compare.Input) async throws -> Operations.Compare.Output {
        guard case .json(let body) = input.body else {
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

        let fromDate = makeDateFields(from: body.fromDate)
        let toDate = makeDateFields(from: body.toDate)

        guard let mode = DateTimeMode(rawValue: body.mode.rawValue) else {
            throw Abort(.badRequest, reason: "Invalid mode")
        }

        do {
            let comparator = DateComparer(
                firstDate: fromDate,
                secondDate: toDate,
                calendar: calendar
            )
            let result = try comparator.calculate(with: mode)

            let response = Components.Schemas.ComparisonResponse(difference: makeDateFieldsFromDateComponents(result))
            return .ok(.init(body: .json(response)))
        } catch {
            return .badRequest(.init(body: .json(.init(code: ErrorCodes.invalidDate.rawValue, reason: "\(error)"))))
        }
    }
}
