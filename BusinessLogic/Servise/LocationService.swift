//
//  LocationService.swift
//  Weather
//
//  Created by Дмитрий Орлянский on 20.02.2021.
//

import Foundation
import CoreLocation

protocol LocationService {
    var lastLocation: CLLocation? { get }

    func registerObserver(_ observer: LocationObserver)
    func removeObserver(_ observer:LocationObserver)
}
