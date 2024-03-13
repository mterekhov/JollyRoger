//
//  NSManagedObjectContext+Extension.swift
//  JollyRoger
//
//  Created by cipher on 13.03.2024.
//

import CoreData

extension NSManagedObjectContext {
    
    func jellyroger_saveContext() {
        if !hasChanges {
            return
        }
        
        do {
            try save()
        }
        catch let error {
            print(error.localizedDescription)
            return
        }
    }
    
}
