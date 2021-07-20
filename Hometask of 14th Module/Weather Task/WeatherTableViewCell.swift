//
//  WeatherTableViewCell.swift
//  Hometask of 14th Module
//
//  Created by Timur Orazbay on 20.04.2021.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func initCell(item: ListData?) {
        if let data = item {
            dateLabel.text = data.dt_txt
            tempLabel.text = "Temperature: \(data.main?.temp ?? 0)K"
            mainLabel.text = data.weather[0].main
//            descriptionLabel.text = data.weather[0].description
        }
    }
    
}
