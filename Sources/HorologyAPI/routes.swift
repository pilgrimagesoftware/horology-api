//
//  routes.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Vapor

func routes(_ app: Application) throws {
    app.register(collection: ConvertController())
}
