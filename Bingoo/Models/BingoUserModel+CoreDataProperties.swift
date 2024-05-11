//
//  BingoUserModel+CoreDataProperties.swift
//  Bingoo
//
//  Created by Sumit Pradhan on 11/05/24.
//
//

import Foundation
import CoreData


extension BingoUserModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BingoUserModel> {
        return NSFetchRequest<BingoUserModel>(entityName: "BingoUserModel")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var userName: String?

}

extension BingoUserModel : Identifiable {
    static private var coreDataStack = CoreDataStack(modelName: "BingoCoreDataModels")
    static var current: BingoUserModel? {
        guard let users = try? coreDataStack.managedContext.fetch(BingoUserModel.fetchRequest()) else {
            return nil
        }
        return users.first
    }
    
    static func updateDetails(userName: String) {
        if current == nil {
            let newUser = BingoUserModel(context: coreDataStack.managedContext)
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
