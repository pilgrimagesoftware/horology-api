//
//  ConvertController.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Vapor

struct ConversionRequest: Content {
    let value: Int
    let unit: String
}

struct ConversionResponse: Content {
    let value: Int
    let approximate: Bool
    let message: String?
}
