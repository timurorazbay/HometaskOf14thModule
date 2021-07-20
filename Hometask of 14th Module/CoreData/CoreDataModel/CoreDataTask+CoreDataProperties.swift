//
//  CoreDataTask+CoreDataProperties.swift
//  
//
//  Created by Timur Orazbay on 18.04.2021.
//
//

import Foundation
import CoreData


extension CoreDataTask {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataTask> {
        return NSFetchRequest<CoreDataTask>(entityName: "CoreDataTask")
    }

    @NSManaged public var taskName: String?
    @NSManaged public var taskDescpription: String?

}
