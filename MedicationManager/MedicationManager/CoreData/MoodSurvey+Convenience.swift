//
//  MoodSurvey+Convenience.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 12/28/20.
//

import CoreData

extension MoodSurvey {
    @discardableResult convenience init(mentalState: String, date: Date, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.mentalState = mentalState
        self.date = date
    }
}
