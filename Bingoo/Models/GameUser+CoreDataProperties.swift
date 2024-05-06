//
//  GameUser+CoreDataProperties.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 06/05/24.
//
//

import Foundation
import CoreData


extension GameUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GameUser> {
        return NSFetchRequest<GameUser>(entityName: "GameUser")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var userName: String?

}

extension GameUser : Identifiable {

}
