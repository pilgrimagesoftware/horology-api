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
            fromComponent: dateComponents.year, type: HorologyCore.DateTimeFieldType.year.rawValue),
        day: makeDateTimeField(fromComponent: dateComponents.year, type: HorologyCore.DateTimeFieldType.year.rawValue),
        hour: makeDateTimeField(fromComponent: dateComponents.year, type: HorologyCore.DateTimeFieldType.year.rawValue),
        minute: makeDateTimeField(
            fromComponent: dateComponents.year, type: HorologyCore.DateTimeFieldType.year.rawValue),
        second: makeDateTimeField(
            fromComponent: dateComponents.year, type: HorologyCore.DateTimeFieldType.year.rawValue))
}
