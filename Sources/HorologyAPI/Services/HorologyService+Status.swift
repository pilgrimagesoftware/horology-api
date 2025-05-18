//
//  HorologyService+Status.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation
import OpenAPIRuntime
import OpenAPIVapor
import Vapor

extension HorologyService {
    func status(_ input: Operations.Status.Input) async throws -> Operations.Status.Output {
        let response = Components.Schemas.StatusResponse(
            date: Date().formatted(.iso8601),
            hostname: Host.current().name)
        return .ok(.init(body: .json(response)))
    }
}
