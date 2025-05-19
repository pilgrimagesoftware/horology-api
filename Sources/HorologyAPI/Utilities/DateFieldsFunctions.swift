//
//  ConvertController.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import HorologyCore

func makeDateFields(from content: Components.Schemas.DateFields) -> HorologyCore.DateFields {
    var fields: [HorologyCore.DateTimeField] = []

    if let year = content.year {
        fields.append(HorologyCore.DateTimeField(type: .year, value: year.value))
    }

    if let month = content.month {
        fields.append(HorologyCore.DateTimeField(type: .month, value: month.value))
    }

    if let day = content.day {
        fields.append(HorologyCore.DateTimeField(type: .day, value: day.value))
    }

    if let hour = content.hour {
        fields.append(HorologyCore.DateTimeField(type: .hour, value: hour.value))
    }

    if let minute = content.minute {
        fields.append(HorologyCore.DateTimeField(type: .minute, value: minute.value))
    }

    if let second = content.second {
        fields.append(HorologyCore.DateTimeField(type: .second, value: second.value))
    }

    return HorologyCore.DateFields(fields: fields)
}
