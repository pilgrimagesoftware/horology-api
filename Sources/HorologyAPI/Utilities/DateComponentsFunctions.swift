//
//  ConvertController.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import HorologyCore
import Vapor

func makeContentFromDateComponents(_ dateComponents: Foundation.DateComponents) -> Components.Schemas.DateComponents {
    return Components.Schemas.DateComponents(
        year: dateComponents.year,
        month: dateComponents.month,
        day: dateComponents.day,
        hour: dateComponents.hour,
        minute: dateComponents.minute,
        second: dateComponents.second)
}

func makeDateFieldsFromDateComponents(_ dateComponents: Foundation.DateComponents) -> Components.Schemas.DateFields {
    return Components.Schemas.DateFields(
        year: makeDateTimeField(fromComponent: dateComponents.year, type: HorologyCore.DateTimeFieldType.year.rawValue),
        month: makeDateTimeField(
            fromComponent: dateComponents.month, type: HorologyCore.DateTimeFieldType.month.rawValue),
        day: makeDateTimeField(fromComponent: dateComponents.day, type: HorologyCore.DateTimeFieldType.day.rawValue),
        hour: makeDateTimeField(fromComponent: dateComponents.hour, type: HorologyCore.DateTimeFieldType.hour.rawValue),
        minute: makeDateTimeField(
            fromComponent: dateComponents.minute, type: HorologyCore.DateTimeFieldType.minute.rawValue),
        second: makeDateTimeField(
            fromComponent: dateComponents.second, type: HorologyCore.DateTimeFieldType.second.rawValue))
}
