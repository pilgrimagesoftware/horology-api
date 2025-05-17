//
//  ConvertController.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import HorologyCore

func makeDateTimeField(from content: HorologyAPI.DateTimeField) -> HorologyCore.DateTimeField? {
    switch content.type {
    case "year", "month", "day", "hour", "minute", "second":
        guard let type = DateTimeFieldType(rawValue: content.type) else { return nil }
        return HorologyCore.DateTimeField(type: type, value: content.value)
    default:
        return nil
    }
}
