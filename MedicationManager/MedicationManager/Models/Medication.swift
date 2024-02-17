//
//  Medication.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 2/1/24.
//

import Foundation

struct Medication {
    var id: UUID = UUID()
    var name: String
    var timeOfDay: Date
    var takenDates: [TakenDate]
    
    func wasTakenToday() -> Bool {
        takenDates.contains(where: { Calendar.current.isDate($0.date, inSameDayAs: Date()) })
    }
}
