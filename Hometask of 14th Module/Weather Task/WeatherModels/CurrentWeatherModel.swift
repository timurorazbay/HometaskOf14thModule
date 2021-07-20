//
//  WeatherModel.swift
//  Hometask of 14th Module
//
//  Created by Timur Orazbay on 18.04.2021.
//

import Foundation
import RealmSwift

class CurrentWeatherGeneralModel: Object, Decodable {
    
    var weather = List<WeatherDescription>()
    @objc dynamic var main: MainDescription?
    @objc dynamic var name: String?
}

class WeatherDescription: Object, Decodable {
    
    @objc dynamic var main: String?
//    @objc dynamic var description: String?
}

class MainDescription: Object, Decodable {
    
    @objc dynamic var temp: Double = 0
    @objc dynamic var pressure: Int = 0
    @objc dynamic var humidity: Int = 0
}
