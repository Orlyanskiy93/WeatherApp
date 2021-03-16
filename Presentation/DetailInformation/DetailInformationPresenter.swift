//
//  DetailInformationPresenter.swift
//  Weather
//
//  Created by Дмитрий Орлянский on 22.02.2021.
//

import Foundation

class DetailInformationPresenter: DetailInformationViewOutput {
    weak var view: DetailInformationViewInput?
    
    init(view: DetailInformationViewInput) {
        self.view = view
    }
    
    func viewIsReady() {
        view?.fillLabels()
    }
}
