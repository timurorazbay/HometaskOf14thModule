//
//  DisplaySavedDataForCW.swift
//  Hometask of 14th Module
//
//  Created by Timur Orazbay on 27.04.2021.
//

import Foundation
import UIKit

class DisplaySavedData {
    
    static let shared = DisplaySavedData()
    
    func displaySavedDataForCW(name: UILabel, main: UILabel, temp: UILabel, pressure: UILabel, humidity: UILabel) {
        WeatherRequestRealization.shared.currentWeather = WeatherRequestRealization.shared.realm.objects(CurrentWeatherGeneralModel.self)
        name.text = WeatherRequestRealization.shared.currentWeather.last?.name
        main.text = WeatherRequestRealization.shared.currentWeather.last?.weather.last?.main
        temp.text = "Temperatur: \(WeatherRequestRealization.shared.currentWeather.last?.main?.temp ?? 0)K"
        pressure.text = "Pressure: \(WeatherRequestRealization.shared.currentWeather.last?.main?.pressure ?? 0)hPa"
        humidity.text = "Humidity: \(WeatherRequestRealization.shared.currentWeather.last?.main?.humidity ?? 0)%"
    }
    
}
