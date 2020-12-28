//
//  TakenDate+Convenience.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 12/23/20.
//

import CoreData

extension TakenDate {
    @discardableResult convenience init(date: Date, medication: Medication, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.date = date
        self.medication = medication
    }
}
