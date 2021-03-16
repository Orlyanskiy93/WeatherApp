//
//  ViewController.swift
//  Weather
//
//  Created by Дмитрий Орлянский on 19.01.2021.
//

import UIKit
import Kingfisher

class CurrentWeatherViewController: UIViewController, CurrentWeatherViewInput  {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var activitiIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!

    var output: CurrentWeatherViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output = CurrentWeatherPresenter(view: self)
        output.viewIsReady()
    }
    
    func setupInitialState() {
        activitiIndicator.hidesWhenStopped = true
        container.isHidden = true
    }
        
    func stopLoading() {
        activitiIndicator.stopAnimating()
        container.isHidden = false
    }
    
    func startLoading() {
        activitiIndicator.startAnimating()
        container.isHidden = true
    }
    
    func fill(weather: Weather) {
        let url = URL(string: "https://openweathermap.org/img/wn/\(weather.icon).png")
        weatherImage.kf.setImage(with: url)
        tempLabel.text = weather.temp.description + " °C"
        descriptionLabel.text = weather.description
        minTempLabel.text = weather.tempMin.description + " °C"
        maxTempLabel.text = weather.tempMax.description + " °C"
        pressureLabel.text = weather.pressure.description
        humidityLabel.text = weather.humidity.description
        windSpeedLabel.text = weather.windSpeed.description
    }
}
