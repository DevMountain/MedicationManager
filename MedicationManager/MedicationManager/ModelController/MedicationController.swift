//
//  MedicationController.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 12/21/20.
//

import CoreData

class MedicationController {

    static let shared = MedicationController()

    private init() {}

    var medications: [Medication] = []

    func createMedication(name: String, timeOfDay: Date) {
        let medication = Medication(name: name, timeOfDay: timeOfDay)
        medications.append(medication)
    }

    func updateMedication(_ medication: Medication) {
        
    }

    func deleteMedication() {

    }
    
}
