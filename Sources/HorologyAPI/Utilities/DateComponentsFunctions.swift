//
//  ConvertController.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import Vapor

func makeContentFromDateComponents(_ dateComponents: Foundation.DateComponents) -> HorologyAPI.DateComponents {
    return DateComponents(
        year: dateComponents.year,
        month: dateComponents.month,
        day: dateComponents.day,
        hour: dateComponents.hour,
        minute: dateComponents.minute,
        second: dateComponents.second)
}
