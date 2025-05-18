//
//  HorologyService+Calculate.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation
import OpenAPIRuntime
import OpenAPIVapor
import Vapor

extension HorologyService {
      func calculate(_ input: Operations.Calculate.Input) async throws -> Operations.Calculate.Output
    {
        let response = Components.Schemas.CalculationResponse()
        return .ok(.init(body: .json(response)))
    }
}
