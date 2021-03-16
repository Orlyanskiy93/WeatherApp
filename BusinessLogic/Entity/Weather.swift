//
//  Weather.swift
//  Weather
//
//  Created by Дмитрий Орлянский on 21.01.2021.
//

import Foundation
import ObjectMapper

struct Weather: ImmutableMappable {
    var temp: Double
    var description: String
    var tempMin: Double
    var tempMax: Double
    var pressure: Double
    var humidity: Double
    var windSpeed: Double
    var icon: String
    var date: Date

    init(map: Map) throws {
        temp = try map.value("main.temp")
        description = try map.value("weather.0.description")
        tempMin = try map.value("main.temp_min")
        tempMax = try map.value("main.temp_max")
        pressure = try map.value("main.pressure")
        humidity = try map.value("main.humidity")
        windSpeed = try map.value("wind.speed")
        icon = try map.value("weather.0.icon")
        date = try map.value("dt", using: DateTransform())
    }
}
