//
//  DetailInformationViewIO.swift
//  Weather
//
//  Created by Дмитрий Орлянский on 22.02.2021.
//

import UIKit

protocol DetailInformationViewInput: class, UIViewInput {
    func fillLabels()
}

protocol DetailInformationViewOutput {
    func viewIsReady()
}
