//
//  ForecastModel.swift
//  Hometask of 14th Module
//
//  Created by Timur Orazbay on 18.04.2021.
//

import Foundation
import RealmSwift

class ForecastGeneralModel: Object, Decodable {
    
    var list = List<ListData>()
    @objc dynamic var city: CityName?
}

class ListData: Object, Decodable {
    
    var weather =  List<WeatherData>()
    @objc dynamic var main: MainData?
    @objc dynamic var dt_txt: String?
}

class WeatherData: Object, Decodable {
    
    @objc dynamic var main: String?
//    @objc dynamic var description: String
}

class MainData: Object, Decodable {
    
    @objc dynamic var temp: Double = 0
}

class CityName: Object, Decodable {
    
    @objc dynamic var name: String?
}

