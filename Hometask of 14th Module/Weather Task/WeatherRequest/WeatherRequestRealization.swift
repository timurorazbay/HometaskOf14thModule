//
//  WeatherRequestRealization.swift
//  Hometask of 14th Module
//
//  Created by Timur Orazbay on 18.04.2021.
//

import Foundation
import UIKit
import RealmSwift

class WeatherRequestRealization {
    
    static let shared = WeatherRequestRealization()
    
    let realm = try! Realm()
                    
//    MARK: - Реализация запроса для текущей погоды
    
    var currentWeather: Results<CurrentWeatherGeneralModel>!
    
    func requestCW(url: String, name: UILabel, main: UILabel, description: UILabel, temp: UILabel, pressure: UILabel, humidity: UILabel) {
        WeatherRequest.shared.currentWeatherRequest(url: url) { (result) in
            switch result {
            
            case .success(let value):
//                print(value)
                
                let weatherDescriptionModel = List<WeatherDescription>()
                let obj = WeatherDescription()
                value.weather.forEach {
                    obj.main = $0.main
                }
                weatherDescriptionModel.append(obj)
                
                let mainDescriptionModel = MainDescription()
                mainDescriptionModel.temp = value.main?.temp ?? 0
                mainDescriptionModel.pressure = value.main?.pressure ?? 0
                mainDescriptionModel.humidity = value.main?.humidity ?? 0
                
                let generalModel = CurrentWeatherGeneralModel()
                generalModel.name = value.name
                generalModel.main = mainDescriptionModel
                generalModel.weather = weatherDescriptionModel
                
                name.text = generalModel.name
                main.text = obj.main
                temp.text = "Temperature: \(mainDescriptionModel.temp)К"
                pressure.text = "Pressure: \(mainDescriptionModel.pressure)hPa"
                humidity.text = "Humidity: \(mainDescriptionModel.humidity)%"
                
                try! self.realm.write {
                    self.realm.add(generalModel)
                }
                                
            case .failure(let error):
                print(error)
            }
        }
    }
    
//    MARK: - Реализация запроса для погоды на каждые 3 часа
    
    var forecast: Results<ForecastGeneralModel>! = nil
        
    func requestF(url: String, tableView: UITableView) {
        WeatherRequest.shared.forecastRequest(url: url) { (result) in
            switch result {
            
            case .success(let value):
//                print(value)
                
                var forecastModel: [ForecastGeneralModel] = []
                forecastModel.append(value)

                let cityNameModel = CityName()
                forecastModel.forEach { data in
                    cityNameModel.name = data.city?.name
                }

                let listDataModel = List<ListData>()
                forecastModel.forEach { data in
                    let model = data.list
                    let arrayModel = Array(model)
                    let filteredArrayModel = arrayModel.filter { ($0.dt_txt?.contains("12:00:00"))! }
                    listDataModel.append(objectsIn: filteredArrayModel)
                }

                let forecastGeneralModel = ForecastGeneralModel()
                forecastGeneralModel.list = listDataModel
                forecastGeneralModel.city = cityNameModel

                try! self.realm.write({
                    self.realm.add(forecastGeneralModel)
                })
              
                tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

      //MARK: - Модель

//                let cityNameModel = CityName()
//                cityNameModel.name = value.city?.name
//
//                let mainDataModel = MainData()
//                value.list.forEach {
//                    mainDataModel.temp = $0.main?.temp ?? 0
//                }
//
//                let weatherDataModel = List<WeatherData>()
//                let objWeatherDataModel = WeatherData()
//                objWeatherDataModel.main = value.list.last?.weather.last?.main
//                weatherDataModel.append(objWeatherDataModel)
//
//                let listDataModel = List<ListData>()
//                let objListDataModel = ListData()
//                objListDataModel.weather = weatherDataModel
//                objListDataModel.main = mainDataModel
//                value.list.forEach {
//                    objListDataModel.dt_txt = $0.dt_txt
//                }
//                listDataModel.append(objListDataModel)
//                print(objListDataModel.dt_txt)
//
//                let forecastGeneralModel = ForecastGeneralModel()
//                forecastGeneralModel.city = cityNameModel
//                forecastGeneralModel.list = listDataModel


//                let listData = [["dt_txt":"12:00:00"], ["dt_txt":"15:00:00"]]
//                let filteredArray = listData.filter {
//                    $0 == ["dt_txt":"12:00:00"]
//                }
//                print(filteredArray)
