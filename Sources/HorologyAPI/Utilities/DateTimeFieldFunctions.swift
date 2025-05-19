//
//  ConvertController.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import HorologyCore

func makeDateTimeField(fromContent content: Components.Schemas.DateTimeField) -> HorologyCore.DateTimeField? {
    switch content._type {
    case "year", "month", "day", "hour", "minute", "second":
        guard
            let type = DateTimeFieldType(rawValue: content._type)
        else { return nil }
        return HorologyCore.DateTimeField(type: type, value: content.value)
    default:
        return nil
    }
}

func makeDateTimeField(fromComponent component: Int?, type: String) -> Components.Schemas.DateTimeField? {
    guard let component else { return nil }

    return Components.Schemas.DateTimeField(_type: type, value: component)
}
