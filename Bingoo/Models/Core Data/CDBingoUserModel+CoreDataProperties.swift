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
    static private var coreDataStack = CoreDataStack(modelName: "BingoCoreDataModels")
    static var current: CDBingoUserModel? {
        guard let users = try? coreDataStack.managedContext.fetch(CDBingoUserModel.fetchRequest()) else {
            return nil
        }
        return users.first
    }
    
    static func updateDetails(userName: String) {
        if current == nil {
            let newUser = CDBingoUserModel(context: coreDataStack.managedContext)
            newUser.userName = userName
        } else {
            current?.userName = userName
        }
        do {
            if coreDataStack.managedContext.hasChanges {
                try coreDataStack.managedContext.save()
            }
        } catch {
            print("Error updating username \(error.localizedDescription)")
        }
    }
}
