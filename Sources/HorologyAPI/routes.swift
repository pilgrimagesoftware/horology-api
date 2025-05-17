//
//  routes.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: ConvertController())
    try app.register(collection: CalculateController())
    try app.register(collection: CompareController())
}
