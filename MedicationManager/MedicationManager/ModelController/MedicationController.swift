//
//  MedicationController.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 12/21/20.
//

import CoreData
import UserNotifications

class MedicationController {

    static let shared = MedicationController()
    let notificationScheduler = NotificationScheduler()

    private lazy var fetchRequest: NSFetchRequest<Medication> = {
        let request = NSFetchRequest<Medication>(entityName: Strings.medicationEntityType)
        request.predicate = NSPredicate(value: true)
        return request
    }()

    var sections: [[Medication]] { [notTakenMeds, takenMeds] }
    var notTakenMeds: [Medication] = []
    var takenMeds: [Medication] = []
    var moodSurvey: MoodSurvey?

    private init() {}

    func createMedication(name: String, timeOfDay: Date) {
        let medication = Medication(name: name, timeOfDay: timeOfDay)
        notTakenMeds.append(medication)
        
        CoreDataStack.saveContext()

        notificationScheduler.scheduleNotifications(for: medication)
    }

    func fetchMedications() {
        let medications = (try? CoreDataStack.context.fetch(self.fetchRequest)) ?? []
        takenMeds = medications.filter { $0.wasTakenToday() }
        notTakenMeds = medications.filter { !$0.wasTakenToday() }
    }

    func updateMedicationDetails(_ medication: Medication, name: String, timeOfDay: Date) {
        medication.name = name
        medication.timeOfDay = timeOfDay
        CoreDataStack.saveContext()

        notificationScheduler.scheduleNotifications(for: medication)
    }

    func updateMedicationTakenStatus(_ wasTaken: Bool, medication: Medication) {
        if wasTaken {
            TakenDate(date: Date(), medication: medication)
            if let index = notTakenMeds.firstIndex(of: medication) {
                notTakenMeds.remove(at: index)
                takenMeds.append(medication)
            }
        } else {
            let mutableTakenDates = medication.mutableSetValue(forKey: Strings.takenDates)

            if let takenDate = (mutableTakenDates as? Set<TakenDate>)?.first(where: { takenDate in
                guard let date = takenDate.date
                else { return false }

                return Calendar.current.isDate(date, inSameDayAs: Date())
            }) {
                mutableTakenDates.remove(takenDate)
                if let index = takenMeds.firstIndex(of: medication) {
                    takenMeds.remove(at: index)
                    notTakenMeds.append(medication)
                }
            }
        }
        CoreDataStack.saveContext()
    }

    func markMedicationAsTaken(withID id: String) {
        guard let uuid = UUID(uuidString: id),
              let medication = notTakenMeds.first(where: { $0.id == uuid })
        else { return }

        TakenDate(date: Date(), medication: medication)
        CoreDataStack.saveContext()
    }

    func deleteMedication(_ medication: Medication) {
        if let index = notTakenMeds.firstIndex(of: medication) {
            notTakenMeds.remove(at: index)
        } else if let index = takenMeds.firstIndex(of: medication) {
            takenMeds.remove(at: index)
        }

        CoreDataStack.context.delete(medication)
        CoreDataStack.saveContext()
        
        notificationScheduler.clearNotifications(for: medication)
    }
    
}
