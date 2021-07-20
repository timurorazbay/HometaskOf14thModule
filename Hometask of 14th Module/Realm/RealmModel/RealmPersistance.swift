//
//  RealmPersistance.swift
//  Hometask of 14th Module
//
//  Created by Timur Orazbay on 17.04.2021.
//

import Foundation
import RealmSwift

class Task: Object {
    @objc dynamic var taskName: String = ""
    @objc dynamic var taskDescription: String = ""
}
