//
//  ConvertController.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Vapor
import HorologyCore


struct ConversionRequest: Content {
    let value: Int
    let from: String
    let to: String
}

struct ConversionResponse: Content {
    let value: Int
    let approximate: Bool
    let message: String?
}

struct ConvertController: RouteCollection {
    func boot(routes: any RoutesBuilder) throws {
        let convertRoute = routes.grouped("convert")

        convertRoute.group("years", ":value") { years in
            years.get(use: toYears)
        }
    }

    func toYears(req: Request) async throws -> Response {
        req.logger.info("Converting to years: \(req.url.path)")

        let conversion = try req.content.decode(ConversionRequest.self)

        let to : ConversionValueType = .years
        let from : ConversionValueType = .seconds // TODO: Get this from the request

        let converter = ValueConverter(value: conversion.value, valueType: from)
        let result = converter.convert(to: to)

        let response = ConversionResponse(value: result.value, approximate: result.approximate, message: nil)
        return try await req.jsonResponse(response)
    }

}
