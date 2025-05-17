//
//  ConvertController.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Vapor

struct ErrorResponse: Content {
    let error: Bool
    let reason: String
}
