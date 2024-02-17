//
//  MedicationController.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 12/21/20.
//

import UserNotifications

protocol MedicationProviding {
    func createMedication(name: String, timeOfDay: Date) -> Medication
    func fetchMedications() -> [Medication]
    func updateMedicationDetails(_ medication: Medication, name: String, timeOfDay: Date)
    func updateMedicationTakenStatus(_ wasTaken: Bool, medication: Medication)
    func markMedicationAsTaken(withID id: String)
    func deleteMedication(_ medication: Medication)
}

class MedicationController {
    
    static let shared = MedicationController()
    let notificationScheduler = NotificationScheduler()
    
    var sections: [[Medication]] { [notTakenMeds, takenMeds] }
    var notTakenMeds: [Medication] = []
    var takenMeds: [Medication] = []
    var moodSurvey: MoodSurvey?
    
    private var medicationProvider: MedicationProviding = CoreDataMedicationManager()
    
    private init() {}

    func createMedication(name: String, timeOfDay: Date) {
        let medication = medicationProvider.createMedication(name: name, timeOfDay: timeOfDay)

        notificationScheduler.scheduleNotifications(for: medication)
        fetchMedications()
    }

    func fetchMedications() {
        let medications = medicationProvider.fetchMedications()
        takenMeds = medications.filter { $0.wasTakenToday() }
        notTakenMeds = medications.filter { !$0.wasTakenToday() }
    }

    func updateMedicationDetails(_ medication: Medication, name: String, timeOfDay: Date) {
        medicationProvider.updateMedicationDetails(medication, name: name, timeOfDay: timeOfDay)
        notificationScheduler.scheduleNotifications(for: medication)
        fetchMedications()
    }

    func updateMedicationTakenStatus(_ wasTaken: Bool, medication: Medication) {
        medicationProvider.updateMedicationTakenStatus(wasTaken, medication: medication)
        fetchMedications()
    }

    func markMedicationAsTaken(withID id: String) {
        medicationProvider.markMedicationAsTaken(withID: id)
        fetchMedications()
    }

    func deleteMedication(_ medication: Medication) {
        medicationProvider.deleteMedication(medication)
        notificationScheduler.clearNotifications(for: medication)
        fetchMedications()
    }
    
}
