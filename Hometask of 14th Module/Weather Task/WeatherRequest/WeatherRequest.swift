//
//  WeatherRequest.swift
//  Hometask of 14th Module
//
//  Created by Timur Orazbay on 18.04.2021.
//

import Foundation
import Alamofire
import RealmSwift

class WeatherRequest {
    
    static let shared = WeatherRequest()
    
//    MARK: - Метод запроса для текущей погоды
    
    func currentWeatherRequest(url: String, completion: @escaping (Result<CurrentWeatherGeneralModel, Error>) -> Void) {
        AF.request(url).responseDecodable(of: CurrentWeatherGeneralModel.self) { (responseJSON) in
            switch responseJSON.result {
            case .success(let value):
//                print(value)
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
//    MARK: - Метод запроса для погоды на каждые 3 часа
    
    func forecastRequest(url: String, completion: @escaping (Result<ForecastGeneralModel, Error>) -> Void) {
        AF.request(url).responseDecodable(of: ForecastGeneralModel.self) { (responseJSON) in
            switch responseJSON.result {
            case .success(let value):
//                print(value)
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
