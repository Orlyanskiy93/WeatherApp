//
//  Location.swift
//  Weather
//
//  Created by Дмитрий Орлянский on 16.02.2021.
//

import Foundation
import CoreLocation

class LocationServiceImp: NSObject, CLLocationManagerDelegate, LocationService {
    private var locationManager = CLLocationManager()
    private var observers: [WeakBox] = []
    var lastLocation: CLLocation? {
        return locationManager.location
    }
    
    static var shared = LocationServiceImp()
    private override init() {
        super.init()
        setupLocationManager()
    }
        
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        notifyObservers()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .denied || manager.authorizationStatus == .notDetermined {
            observers.forEach { (box) in
                box.object?.toSettings()
            }
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        observers.forEach { (observer) in
            observer.object?.didGet(error)
        }
    }
}

extension LocationServiceImp: LocationSubject {
    func registerObserver(_ observer: LocationObserver) {
        let weakBox = WeakBox(observer)
        let observerHasAlreadyRegistered = observers.contains { (weakBox) -> Bool in
            return weakBox.object === observer
        }
        guard !observerHasAlreadyRegistered else {
            return
        }
        observers.append(weakBox)
        
        guard let location = locationManager.location else {
            return
        }
        observer.didGet(location)
    }
    
    func removeObserver(_ observer: LocationObserver) {
        observers.removeAll { (weakBox) -> Bool in
            return weakBox.object === observer
        }
    }
    
    func notifyObservers() {
        guard let location = locationManager.location else {
            return
        }
        observers.forEach { (weakBox) in
            weakBox.object?.didGet(location)
        }
    }
}
