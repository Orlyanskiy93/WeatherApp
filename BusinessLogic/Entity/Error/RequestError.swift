//
//  RequestErrors.swift
//  Weather
//
//  Created by Дмитрий Орлянский on 02.02.2021.
//

import Foundation

enum RequestError: LocalizedError {
    case initializationError
    case mapingError
        
    var errorDescription: String? {
        switch self {
        case .initializationError:
            return "Properties cannot be assigned"
        case .mapingError:
            return "Can't map request data to dictionary"
        }
    }
}
