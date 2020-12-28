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
        self.medications = medications
    }

    func updateMedicationDetails(_ medication: Medication, name: String, timeOfDay: Date) {
        medication.name = name
        medication.timeOfDay = timeOfDay
        CoreDataStack.saveContext()
    }

    func updateMedicationTakenStatus(_ wasTaken: Bool, medication: Medication) {
        if wasTaken {
            TakenDate(date: Date(), medication: medication)
        } else {
            let mutableTakenDates = medication.mutableSetValue(forKey: "takenDates")

            if let takenDate = (mutableTakenDates as? Set<TakenDate>)?.first(where: { takenDate in
                guard let date = takenDate.date
                else { return false }

                return Calendar.current.isDate(date, inSameDayAs: Date())
            }) {
                mutableTakenDates.remove(takenDate)
            }
        }
        CoreDataStack.saveContext()
    }

    func deleteMedication() {

    }
    
}
