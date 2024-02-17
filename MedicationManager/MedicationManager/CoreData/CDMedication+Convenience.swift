//
//  CDMedication+Convenience.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 12/21/20.
//

import CoreData

extension CDMedication {
    @discardableResult convenience init(name: String, timeOfDay: Date, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.id = UUID()
        self.name = name
        self.timeOfDay = timeOfDay
    }
}
