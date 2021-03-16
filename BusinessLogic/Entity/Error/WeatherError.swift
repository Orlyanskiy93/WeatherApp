//
//  RequestErrors.swift
//  Weather
//
//  Created by Дмитрий Орлянский on 19.02.2021.
//

import Foundation

enum WeatherError: LocalizedError {
    case forecast
    case location
    case custom(String)

    var errorDescription: String? {
        switch self {
        case .forecast:
            return "Forecast is empty"
        case.location:
            return "Can't define location"
        case .custom(let message):
            return message
        }
    }
}
