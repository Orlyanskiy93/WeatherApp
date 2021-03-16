//
//  CurrentWeatherIO.swift
//  Weather
//
//  Created by Дмитрий Орлянский on 21.01.2021.
//

import Foundation
import CoreLocation

protocol CurrentWeatherViewInput: class, UIViewInput {
    func startLoading()
    func stopLoading()
    func fill(weather: Weather)
    func setupInitialState()
}

protocol CurrentWeatherViewOutput {
    func viewIsReady()
    func getWeather(location: CLLocation)
}
