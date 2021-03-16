//
//  UIViewinput.swift
//  Weather
//
//  Created by Дмитрий Орлянский on 05.02.2021.
//

import UIKit

protocol UIViewInput {
    func show(_ error: Error, alertTitle: String, _ handler: ((UIAlertAction) -> Void)?)
    func show(title: String?, message: String?, alertTitle: String, _ handler: ((UIAlertAction) -> Void)?)
    func toSettings()
}

extension UIViewInput {
    func show(_ error: Error, alertTitle: String = "Ok", _ handler: ((UIAlertAction) -> Void)? = nil) {
        show(title: "Error", message: error.localizedDescription, alertTitle: alertTitle, handler)
    }
    
    func show(title: String?, message: String?, alertTitle: String = "Ok", _ handler: ((UIAlertAction) -> Void)? = nil) {
        guard let vc = self as? UIViewController else { return }
        let allert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: alertTitle, style: .cancel, handler: handler)
        allert.addAction(action)
        vc.present(allert, animated: true, completion: nil)
    }
    
    func toSettings() {
        guard let vc = self as? UIViewController else { return }
        let title = "Allow \"Weather\" to access your location?"
        let message = "Your location needs to show you weather"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionToSettings = UIAlertAction(title: "To settings", style: .default) { (_) in
            let url = URL(string: UIApplication.openSettingsURLString)!
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        let actionCancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(actionToSettings)
        alert.addAction(actionCancel)
        vc.present(alert, animated: true, completion: nil)
    }
    
}
