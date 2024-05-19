//
//  CDBingoUserModel+CoreDataProperties.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 19/05/24.
//
//

import Foundation
import CoreData


extension CDBingoUserModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDBingoUserModel> {
        return NSFetchRequest<CDBingoUserModel>(entityName: "CDBingoUserModel")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var userName: String?

}

extension CDBingoUserModel : Identifiable {

}
