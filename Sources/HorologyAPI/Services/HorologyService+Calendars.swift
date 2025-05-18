//
//  HorologyService+Status.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Foundation
import HorologyCore
import OpenAPIRuntime
import OpenAPIVapor
import Vapor

extension HorologyService {
    func getCalendars(_ input: Operations.GetCalendars.Input) async throws
        -> Operations.GetCalendars.Output
    {
        let response = Components.Schemas.CalendarIdList(
            HorologyCore.calendarIds.map { $0.key }
        )
        return .ok(.init(body: .json(response)))
    }
}
