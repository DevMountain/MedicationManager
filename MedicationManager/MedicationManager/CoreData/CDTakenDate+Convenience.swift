//
//  CDTakenDate+Convenience.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 12/23/20.
//

import CoreData

extension CDTakenDate {
    @discardableResult convenience init(date: Date, medication: CDMedication, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.date = date
        self.medication = medication
    }
}
