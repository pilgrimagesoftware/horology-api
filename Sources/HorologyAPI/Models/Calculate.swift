//
//  ConvertController.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Vapor


struct CalculationRequest: Content {
    let date: HorologyAPI.DateFields
    let adjustments: HorologyAPI.DateFields
    let calendar: String?
    let mode: String
}

struct CalculationResponse: Content {
    let date: String
    let components: HorologyAPI.DateComponents
}
