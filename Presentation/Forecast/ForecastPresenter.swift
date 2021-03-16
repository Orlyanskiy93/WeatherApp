//
//  DailyWeatherPresenter.swift
//  Weather
//
//  Created by Дмитрий Орлянский on 21.01.2021.
//

import Foundation
import CoreLocation
import PromiseKit

class ForecastPresenter: ForecastViewOutput {
    
    var locationService: LocationService = LocationServiceImp.shared
    weak var view: ForecastViewInput!
    var weatherService: WeatherServise = WeatherServiceImp.shared
        
    var forecastArray = [[Weather]]() {
        didSet {
            view.updateData()
        }
    }
    
    init(view: ForecastViewInput) {
        self.view = view
    }
    
    deinit {
        locationService.removeObserver(self)
    }
    
    func viewIsReady() {
        locationService.registerObserver(self)
        view.setupInitialState()
        view.startAnimation()
    }
    
    func tryGetForecastAgain() {
        guard let location = locationService.lastLocation else {
            return
        }
        getForecast(location: location)
    }
    
    func getForecast(location: CLLocation) {
        firstly {
            weatherService.getForecastWeather(location: location)
        } .done { [weak self] (forecast) in
            if let self = self {
                self.forecastArray = self.mapForecastToSectionedArray(forecast: forecast.weatherArray)
                self.view.stopAnimation()
            }
        } .catch { [weak self] (error) in
            self?.view.show(error, alertTitle: "Retry") { (_) in
                self?.tryGetForecastAgain()
            }
        }
    }
    
    func mapForecastToSectionedArray(forecast: [Weather]) -> [[Weather]] {
        var forecast = forecast

        forecast.sort { (firstElement, secondElement) -> Bool in
            return firstElement.date < secondElement.date
        }
        
        guard let firstElement = forecast.first else {
            return [[]]
        }
        
        let calendar = Calendar.current
        var firstDay = calendar.component(.day, from: firstElement.date)
        
        var array = [Weather]()
        var sectionedArray = [[Weather]]()
        
        forecast.forEach { (weather) in
            let day = calendar.component(.day, from: weather.date)
            if firstDay == day {
                array.append(weather)
            } else {
                sectionedArray.append(array)
                array = []
                array.append(weather)
                firstDay = day
            }
        }
        sectionedArray.append(array)
        return sectionedArray
    }
}

extension ForecastPresenter: LocationObserver {
    func toSettings() {
        view.toSettings()
    }
    
    func didGet(_ location: CLLocation) {
        getForecast(location: location)
    }

    func didGet(_ error: Error) {
        view.show(error)
    }
}
