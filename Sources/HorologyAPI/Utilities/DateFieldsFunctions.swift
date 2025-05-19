//
//  ConvertController.swift
//  Horology API
//  Copyright © 2025 Pilgrimage Software. All rights reserved.
//

import HorologyCore

func makeDateFields(from content: Components.Schemas.DateFields) -> HorologyCore.DateFields {
    var fields: [HorologyCore.DateTimeField] = []

    if let year = content.year,
        let value = year.value
    {
        fields.append(HorologyCore.DateTimeField(type: .year, value: value))
    }

    if let month = content.month,
        let value = month.value
    {
        fields.append(HorologyCore.DateTimeField(type: .month, value: value))
    }

    if let day = content.day,
        let value = day.value
    {
        fields.append(HorologyCore.DateTimeField(type: .day, value: value))
    }

    if let hour = content.hour,
        let value = hour.value
    {
        fields.append(HorologyCore.DateTimeField(type: .hour, value: value))
    }

    if let minute = content.minute,
        let value = minute.value
    {
        fields.append(HorologyCore.DateTimeField(type: .minute, value: value))
    }

    if let second = content.second,
        let value = second.value
    {
        fields.append(HorologyCore.DateTimeField(type: .second, value: value))
    }

    return HorologyCore.DateFields(fields: fields)
}
