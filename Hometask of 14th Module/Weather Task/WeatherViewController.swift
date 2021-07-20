//
//  WeatherViewController.swift
//  Hometask of 14th Module
//
//  Created by Timur Orazbay on 20.04.2021.
//

import UIKit
import RealmSwift

class WeatherViewController: UIViewController {
            
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherMainLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
                    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
//        tableView.isHidden = true
//        stackView.isHidden = true
        
        DisplaySavedData.shared.displaySavedDataForCW(name: cityNameLabel, main: weatherMainLabel, temp: tempLabel, pressure: pressureLabel, humidity: humidityLabel)
        
        WeatherRequestRealization.shared.forecast = WeatherRequestRealization.shared.realm.objects(ForecastGeneralModel.self)
    }

    @IBAction func searchButton(_ sender: Any) {
        
        URLModel.shared.urlForCW = "https://api.openweathermap.org/data/2.5/weather?q=\(searchTextField.text!)&appid=bdb0fbf304e9e177188048f7f5713083"
        URLModel.shared.urlForF = "https://api.openweathermap.org/data/2.5/forecast?q=\(searchTextField.text!)&appid=bdb0fbf304e9e177188048f7f5713083"
                    
//        tableView.isHidden = false
//        stackView.isHidden = false
        
        WeatherRequestRealization.shared.requestCW(url: URLModel.shared.urlForCW, name: cityNameLabel, main: weatherMainLabel, description: weatherDescriptionLabel, temp: tempLabel, pressure: pressureLabel, humidity: humidityLabel)
        
        WeatherRequestRealization.shared.requestF(url: URLModel.shared.urlForF, tableView: tableView)

    }
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WeatherRequestRealization.shared.forecast.last?.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! WeatherTableViewCell
        cell.cityNameLabel.text = WeatherRequestRealization.shared.forecast.last?.city?.name
        cell.initCell(item: WeatherRequestRealization.shared.forecast.last?.list[indexPath.row])
        return cell
    }
}
