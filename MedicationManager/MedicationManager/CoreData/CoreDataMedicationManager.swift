//
//  CoreDataMedicationManager.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 2/1/24.
//

import CoreData
import Foundation

class CoreDataMedicationManager: MedicationProviding {
    
    func createMedication(name: String, timeOfDay: Date) -> Medication {
        _ = CDMedication(name: name, timeOfDay: timeOfDay)
        CoreDataStack.saveContext()

        return Medication(name: name, timeOfDay: timeOfDay, takenDates: [])
    }

    func fetchMedications() -> [Medication] {
        let cdMedications = fetchCDMedications()
        
        let medications: [Medication] = cdMedications.compactMap {
            guard let id = $0.id,
                  let name = $0.name,
                  let timeOfDay = $0.timeOfDay,
                  let cdTakenDates = $0.takenDates?.allObjects as? [CDTakenDate]
            else { return nil }

            let takenDates = cdTakenDates.mappedAsTakenDates()
            return Medication(id: id,
                              name: name,
                              timeOfDay: timeOfDay,
                              takenDates: takenDates)
        }
        return medications
    }

    func updateMedicationDetails(_ medication: Medication, name: String, timeOfDay: Date) {
        guard let cdMedication = fetchCDMedication(with: medication.id)
        else { return }
        
        cdMedication.name = name
        cdMedication.timeOfDay = timeOfDay
        CoreDataStack.saveContext()
    }

    func updateMedicationTakenStatus(_ wasTaken: Bool, medication: Medication) {
        guard let cdMedication = fetchCDMedication(with: medication.id)
        else { return }

        if wasTaken {
            CDTakenDate(date: Date(), medication: cdMedication)
        } else {
            guard let cdTakenDates = (cdMedication.takenDates as? Set<CDTakenDate>),
                  let cdTakenDate = cdTakenDates.first(where: {
                      guard let date = $0.date else { return false }
                      
                      return Calendar.current.isDate(date, inSameDayAs: Date())
                  })
            else  { return }

            cdMedication.removeFromTakenDates(cdTakenDate)
        }
        CoreDataStack.saveContext()
    }

    func markMedicationAsTaken(withID id: String) {
        guard let uuid = UUID(uuidString: id),
              let medication = fetchCDMedication(with: uuid)
        else { return }
        
        CDTakenDate(date: Date(), medication: medication)
        CoreDataStack.saveContext()
    }

    func deleteMedication(_ medication: Medication) {
        guard let cdMedication = fetchCDMedication(with: medication.id)
        else { return }
        
        CoreDataStack.context.delete(cdMedication)
        CoreDataStack.saveContext()
    }
    
    // MARK: - Private
    
    private func fetchCDMedications() -> [CDMedication] {
        let request = NSFetchRequest<CDMedication>(entityName: Strings.medicationEntityType)
        request.predicate = NSPredicate(value: true)
        let cdMedications = (try? CoreDataStack.context.fetch(request)) ?? []
        return cdMedications
    }
    
    private func fetchCDMedication(with id: UUID) -> CDMedication? {
        let request = NSFetchRequest<CDMedication>(entityName: Strings.medicationEntityType)
        request.predicate = NSPredicate(format: "id == %@", id.uuidString)
        
        do {
            let results = try CoreDataStack.context.fetch(request)
            return results.first
        } catch {
            print("🔥 There was an error fetching the medication with id \(id). Error: \(error)")
            return nil
        }
    }

}

extension Array where Element == CDTakenDate {
    func mappedAsTakenDates() -> [TakenDate] {
        compactMap {
            guard let date = $0.date else { return nil }
            
            return TakenDate(date: date)
        }
    }
}
