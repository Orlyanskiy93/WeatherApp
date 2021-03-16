//
//  DailyWeatherViewController.swift
//  Weather
//
//  Created by Дмитрий Орлянский on 21.01.2021.
//

import UIKit
import NVActivityIndicatorView

class ForecastViewController: UIViewController, ForecastViewInput {
    @IBOutlet weak var activityIndicator: NVActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var output: ForecastViewOutput!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output = ForecastPresenter(view: self)
        output.viewIsReady()
    }
    
    func setupInitialState() {
        activityIndicator.type = .pacman
        setupTableView()
    }
    
    func setupTableView() {
        let nib = UINib(nibName: ForecastCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ForecastCell.identifier)
        tableView.rowHeight = 65
        tableView.dataSource = self
        tableView.delegate = self
    }
        
    func updateData() {
        tableView.reloadData()
    }
    
    func startAnimation() {
        activityIndicator.startAnimating()
        tableView.isHidden = true
    }
    
    func stopAnimation() {
        activityIndicator.stopAnimating()
        tableView.isHidden = false
    }
    
}

extension ForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return output.forecastArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let firstForecastElement = output.forecastArray[section].first else {
            return nil
        }
        let formater = DateFormatter()
        formater.dateFormat = "dd.MM.yyyy"
        return formater.string(from: firstForecastElement.date)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.forecastArray[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastCell.identifier)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? ForecastCell {
            cell.fillWith(weather: output.forecastArray[indexPath.section][indexPath.row])
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "descriptionSegue", sender: .none)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else {
            return
        }
        tableView.deselectRow(at: indexPath, animated: true)
        let weather = output.forecastArray[indexPath.section][indexPath.row]
        if let detailInformationVC = segue.destination as? DetailInformationViewController {
            detailInformationVC.weather = weather
        }
    }
}
