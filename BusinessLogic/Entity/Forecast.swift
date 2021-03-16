//
//  Forecast.swift
//  Weather
//
//  Created by Дмитрий Орлянский on 08.03.2021.
//

import Foundation
import ObjectMapper

struct Forecast: ImmutableMappable {
    var weatherArray: [Weather]
    
    init(map: Map) throws {
        weatherArray = try map.value("list")
    }
}

