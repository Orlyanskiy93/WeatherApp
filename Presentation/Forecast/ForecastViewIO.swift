//
//  DailyWeatherIO.swift
//  Weather
//
//  Created by Дмитрий Орлянский on 21.01.2021.
//

import Foundation
import CoreLocation

protocol ForecastViewInput: class, UIViewInput {
    func startAnimation()
    func stopAnimation()
    func setupInitialState()
    func updateData()
}

protocol ForecastViewOutput {
    var forecastArray: [[Weather]] { get }
    
    func getForecast(location: CLLocation)
    func viewIsReady()
}
