//
//  Subject.swift
//  Weather
//
//  Created by Дмитрий Орлянский on 20.02.2021.
//

import Foundation

protocol LocationSubject {
    func registerObserver(_ observer: LocationObserver)
    func removeObserver(_ observer: LocationObserver)
    func notifyObservers()
}
