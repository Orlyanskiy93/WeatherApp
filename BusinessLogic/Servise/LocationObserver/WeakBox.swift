//
//  WeakBox.swift
//  Weather
//
//  Created by Дмитрий Орлянский on 22.02.2021.
//

import Foundation

class WeakBox {
    private(set) weak var object: LocationObserver?
    
    init(_ object: LocationObserver) {
        self.object = object
    }
}
