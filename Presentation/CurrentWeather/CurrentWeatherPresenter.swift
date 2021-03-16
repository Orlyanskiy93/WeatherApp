//
//  CurrentWeatherPresenter.swift
//  Weather
//
//  Created by Дмитрий Орлянский on 21.01.2021.
//

import Foundation
import CoreLocation
import PromiseKit

class CurrentWeatherPresenter: CurrentWeatherViewOutput {
    weak var view: CurrentWeatherViewInput!
    var weatherService: WeatherServise = WeatherServiceImp.shared
    var locationService: LocationService = LocationServiceImp.shared

    init(view: CurrentWeatherViewInput) {
        self.view = view
    }
    deinit {
        locationService.removeObserver(self)
    }
        
    func viewIsReady() {
        view.setupInitialState()
        locationService.registerObserver(self)
    }
    
    func tryGetWeather() {
        guard let location = locationService.lastLocation else {
            view.show(WeatherError.location, alertTitle: "Error")
            return
        }
        getWeather(location: location)
    }
    
    func getWeather(location: CLLocation) {
        view.startLoading()
        firstly {
            weatherService.getCurrentWeather(location: location)
        } .done { [weak self] (weather) in
            self?.view.fill(weather: weather)
            self?.view.stopLoading()
        } .catch { [weak self] (error) in
            self?.view.show(error, alertTitle: "Error") { (_) in
                self?.tryGetWeather()
            }
        }
    }
}

extension CurrentWeatherPresenter: LocationObserver {
    func toSettings() {
        view.toSettings()
    }
    
    func didGet(_ location: CLLocation) {
        getWeather(location: location)
    }

    func didGet(_ error: Error) {
        view.show(error)
    }
}
