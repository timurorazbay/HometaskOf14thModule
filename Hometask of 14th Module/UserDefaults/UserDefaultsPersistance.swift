//
//  UserDefaultsPersistance.swift
//  Hometask of 14th Module
//
//  Created by Timur Orazbay on 17.04.2021.
//

import Foundation

class UserDefaultsPersistance {
    
    static let shared = UserDefaultsPersistance()
    
    private let kNameKey = "Persistance.kNameKey"
    var name: String? {
        set { UserDefaults.standard.set(newValue, forKey: kNameKey) }
        get { return UserDefaults.standard.string(forKey: kNameKey) }
    }
    
    private let kSecondNameKey = "Persistance.kSecondNameKey"
    var secondName: String? {
        set { UserDefaults.standard.set(newValue, forKey: kSecondNameKey) }
        get { return UserDefaults.standard.string(forKey: kSecondNameKey) }
    }
    
}
