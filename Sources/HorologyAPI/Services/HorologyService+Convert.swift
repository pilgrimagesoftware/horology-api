//
//  HorologyService+Convert.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation
import HorologyCore
import OpenAPIRuntime
import OpenAPIVapor
import Vapor

extension HorologyService {
    func convert(_ input: Operations.Convert.Input) async throws -> Operations.Convert.Output {
        guard let to = ConversionValueType(rawValue: input.path.to) else {
            return .badRequest(
                .init(
                    body: .json(
                        .init(
                            code: ErrorCodes.invalidUnit.rawValue,
                            reason: "Invalid unit to convert to"))))
        }

        guard case .json(let body) = input.body,
            let unit = body.unit,
            let value = body.value
        else {
            return .badRequest(
                .init(
                    body: .json(.init(code: ErrorCodes.serialization.rawValue,
                     reason: "Request body could not be deserialized")))
            )
        }

        guard let from = ConversionValueType(rawValue: unit) else {
            return .badRequest(
                .init(
                    body: .json(
                        .init(
                            code: ErrorCodes.invalidUnit.rawValue,
                            reason: "Invalid unit to convert from"))))
        }

        let converter = try ValueConverter(value: value, valueType: from)
        let result = try converter.convert(to: to)

        let response = Components.Schemas.ConversionResponse(
            value: result.value, approximate: result.approximate)
        return .ok(.init(body: .json(response)))
    }
}
