//
//  WeatherServiceImp.swift
//  Weather
//
//  Created by Дмитрий Орлянский on 21.01.2021.
//

import Foundation
import Alamofire
import CoreLocation
import ObjectMapper
import PromiseKit

class WeatherServiceImp: WeatherServise {
    static let currentWeatherUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather")!
    static let forecastUrl = URL(string: "https://api.openweathermap.org/data/2.5/forecast")!
    static let appId: String = "2cc2beb2489aa4151c17301123af4ff5"
    
    static let shared = WeatherServiceImp()
    private init() {}
    
    func getCurrentWeather(location: CLLocation) -> Promise<Weather> {
        return Promise { seal in
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            let parametrs: Parameters = ["appid": WeatherServiceImp.appId,
                                         "lat": lat.description,
                                         "lon": lon.description,
                                         "units": "metric"]
            AF.request(WeatherServiceImp.currentWeatherUrl, parameters: parametrs)
                .validate()
                .responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    do {
                        let weather = try Mapper<Weather>().map(JSONObject: data)
                        seal.fulfill(weather)
                    } catch {
                        seal.reject(error)
                    }
                case .failure(let error):
                    guard let data = response.data,
                          let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                          let message = dict["message"] as? String else {
                        seal.reject(error)
                        return
                    }
                    let requestError = WeatherError.custom(message)
                    seal.reject(requestError)
                }
            }
        }
    }
    
    func getForecastWeather(location: CLLocation) -> Promise<Forecast> {
        return Promise { seal in
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            let parametrs: Parameters = ["appid": WeatherServiceImp.appId,
                                         "lat": lat.description,
                                         "lon": lon.description,
                                         "units": "metric"]
            AF.request(WeatherServiceImp.forecastUrl, parameters: parametrs)
                .validate()
                .responseJSON { (response) in
                switch response.result {
                case .success(let data):
                    do {
                        let forecast = try Mapper<Forecast>().map(JSONObject: data)
                        seal.fulfill(forecast)
                    } catch {
                        seal.reject(error)
                    }
                case .failure(let error):
                    guard let data = response.data,
                          let dict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                          let message = dict["message"] as? String else {
                        seal.reject(error)
                        return
                    }
                    let requestError = WeatherError.custom(message)
                    seal.reject(requestError)
                }
            }
        }
    }
}
