//
//  CalculateController.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import HorologyCore
import Vapor


struct CalculateController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let calcRoute = routes.grouped("calculate")

        calcRoute.get(use: calcHandler)
    }

    func calcHandler(req: Request) async throws -> CalculationResponse {
        req.logger.info("Calculating: \(req.url.path)")
        let request = try req.content.decode(CalculationRequest.self)

        let calendar = Calendar.from(identifier: request.calendar ?? "gregorian")

        let startDate = makeDateFields(from: request.date)
        let adjustments = makeDateFields(from: request.adjustments)

        guard let mode = DateTimeMode(rawValue: request.mode) else {
            throw Abort(.badRequest, reason: "Invalid mode")
        }

        let calculator = DateCalculator(
            startDate: startDate,
            adjustments: adjustments,
            calendar: calendar)

        let result = try calculator.calculateDate(with: mode)

        let response = CalculationResponse(
            date: result.formatted(.iso8601),
            components: makeContentFromDateComponents(
                calendar.dateComponents(
                    [.year, .month, .day, .hour, .minute, .second], from: result)),
        )
        return response
    }
}
