//
//  ConvertController.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Vapor

struct DateFields: Content {
    let year: HorologyAPI.DateTimeField?
    let month: HorologyAPI.DateTimeField?
    let day: HorologyAPI.DateTimeField?
    let hour: HorologyAPI.DateTimeField?
    let minute: HorologyAPI.DateTimeField?
    let second: HorologyAPI.DateTimeField?
}

struct DateTimeField: Content {
    let type: String
    let value: Int
}
