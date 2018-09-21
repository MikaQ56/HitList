//
//  PeopleService.swift
//  HitList
//
//  Created by Mickael on 21/09/2018.
//  Copyright © 2018 Mickael. All rights reserved.
//

import Foundation
import CoreData

class PeopleService {
    
    var people: [NSManagedObject] = []
    
    func save(name: String, appDelegate: AppDelegate) {
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)!
        let person = NSManagedObject(entity: entity, insertInto: managedContext)
        person.setValue(name, forKeyPath: "name")
        do {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetch(appDelegate: AppDelegate) {
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Person")
        do {
            people = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
