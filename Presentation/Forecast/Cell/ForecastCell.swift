//
//  ForecastCell.swift
//  Weather
//
//  Created by Дмитрий Орлянский on 04.02.2021.
//

import UIKit
import Kingfisher

class ForecastCell: UITableViewCell {
    static let identifier = "ForecastCell"
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    
    lazy var dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("HH:mm")
        return df
    }()
    
    func fillWith(weather: Weather) {
        let url = URL(string: "https://openweathermap.org/img/wn/\(weather.icon).png")
        weatherIcon.kf.setImage(with: url)
        tempLabel.text = weather.temp.description + "°C"
        timeLabel.text = dateFormatter.string(from: weather.date)
    }
}
