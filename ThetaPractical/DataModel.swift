//
//  DataModel.swift
//  ThetaPractical
//
//  Created by nikunj sareriya on 28/04/22.
//

import Foundation
import CoreData
import UIKit

class DataModel: NSObject {
    static let sharedInstance = DataModel()
    
    // MARK: - Save data in coredata
    
    func saveContext() {
        DispatchQueue.main.async {
            appDelegate.saveContext()
        }
    }
    
    // MARK: - Get data from coredata
    
    func getUserData() -> [UserDetail] {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "UserDetail")
        request.returnsObjectsAsFaults = false
        do {
            if let result = try context.fetch(request) as? [UserDetail] {
                return result
            }
            return []
        } catch {
        }
        return []
    }
    
    // MARK: - Set data in coredata
    
    func setUserData(userData: UserModel) {
        let context = appDelegate.persistentContainer.viewContext
        guard let employee = NSEntityDescription.insertNewObject(forEntityName: "UserDetail", into: context) as? UserDetail else { return }
        employee.setValue(userData.email, forKey: "email")
        employee.setValue(userData.name, forKey: "name")
        employee.setValue(userData.age, forKey: "age")
        self.saveContext()
    }
    
    // MARK: - Delete data in coredata
    
    func deleteUserDetails() -> Bool {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"UserDetail")
        do {
            if let fetchedResults =  try managedContext.fetch(fetchRequest) as? [NSManagedObject] {
                for entity in fetchedResults {
                    managedContext.delete(entity)
                }
                self.saveContext()
                return true
            }
            return false
        } catch {
            print("Could not delete")

        }
        return false
    }
}


