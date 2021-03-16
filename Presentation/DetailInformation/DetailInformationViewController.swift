//
//  DetailInformationViewController.swift
//  Weather
//
//  Created by Дмитрий Орлянский on 16.02.2021.
//

import UIKit
import Kingfisher

class DetailInformationViewController: UIViewController, DetailInformationViewInput {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    var weather: Weather!
    var output: DetailInformationViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        output = DetailInformationPresenter(view: self)
        output.viewIsReady()
    }
    
    func fillLabels() {
        let url = URL(string: "https://openweathermap.org/img/wn/\(weather.icon).png")
        icon.kf.setImage(with: url)
        tempLabel.text = weather.temp.description + "°C"
        descriptionLabel.text = weather.description
        minTempLabel.text = weather.tempMin.description + "°C"
        maxTempLabel.text = weather.tempMax.description + "°C"
        pressureLabel.text = weather.pressure.description
        humidityLabel.text = weather.humidity.description
        windSpeedLabel.text = weather.windSpeed.description
    }
}
