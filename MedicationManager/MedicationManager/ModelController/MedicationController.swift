//
//  MedicationController.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 12/21/20.
//

import CoreData

class MedicationController {

    static let shared = MedicationController()

    private lazy var fetchRequest: NSFetchRequest<Medication> = {
        let request = NSFetchRequest<Medication>(entityName: "Medication")
        request.predicate = NSPredicate(value: true)
        return request
    }()

    private init() {}

    var medications: [Medication] = []

    func createMedication(name: String, timeOfDay: Date) {
        let medication = Medication(name: name, timeOfDay: timeOfDay)
        medications.append(medication)
        CoreDataStack.saveContext()
    }

    func fetchMedications() {
        let medications = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []
        print(medications.count)
        self.medications = medications
    }

    func updateMedication(_ medication: Medication) {
        CoreDataStack.saveContext()
    }

    func deleteMedication() {

    }
    
}
