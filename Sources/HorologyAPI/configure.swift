//
//  configure.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.views.use(.leaf)

    // register routes
    try routes(app)
}
