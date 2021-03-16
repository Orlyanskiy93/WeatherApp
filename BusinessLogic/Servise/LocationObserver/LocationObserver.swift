//
//  Observer.swift
//  Weather
//
//  Created by Дмитрий Орлянский on 20.02.2021.
//

import Foundation
import CoreLocation

protocol LocationObserver: class {
    func didGet(_ location: CLLocation)
    func didGet(_ error: Error)
    func toSettings()
}
