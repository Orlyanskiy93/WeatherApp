//
//  WeatherService.swift
//  Weather
//
//  Created by Дмитрий Орлянский on 21.01.2021.
//

import Foundation
import CoreLocation
import PromiseKit

protocol WeatherServise {
    func getCurrentWeather(location: CLLocation) -> Promise<Weather>
    func getForecastWeather(location: CLLocation) -> Promise<Forecast>
}
