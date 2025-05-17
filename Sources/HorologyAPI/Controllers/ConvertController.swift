//
//  ConvertController.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import HorologyCore
import Vapor

struct ConvertController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let convertRoute = routes.grouped("convert")

        convertRoute.group(":to") { to in
            to.get(use: convertToHandler)
        }
    }

    func convertToHandler(req: Request) async throws -> ConversionResponse {
        req.logger.info("Converting: \(req.url.path)")

        guard let toValue = req.parameters.get("to") else {
            throw Abort(.badRequest, reason: "Missing conversion type")
        }
        guard let to = ConversionValueType(rawValue: toValue) else {
            throw Abort(.badRequest, reason: "Invalid conversion type")
        }

        let conversion = try req.content.decode(ConversionRequest.self)

        guard let from = ConversionValueType(rawValue: conversion.unit) else {
            throw Abort(.badRequest, reason: "Invalid unit")
        }

        let converter = try ValueConverter(value: conversion.value, valueType: from)
        let result = try converter.convert(to: to)

        let response = ConversionResponse(
            value: result.value, approximate: result.approximate, message: nil)
        return response
    }

}
