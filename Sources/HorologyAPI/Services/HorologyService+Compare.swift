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
      func compare(_ input: Operations.Compare.Input) async throws -> Operations.Compare.Output
    {


        let response = Components.Schemas.ComparisonResponse()
        return .ok(.init(body: .json(response)))
    }
}
