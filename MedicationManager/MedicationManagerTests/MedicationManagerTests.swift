//
//  MedicationManagerTests.swift
//  MedicationManagerTests
//
//  Created by Chris Withers on 6/16/22.
//

import XCTest
@testable import MedicationManager

class MedicationManagerTests: XCTestCase {

    override func tearDownWithError() throws {
        // Delete the medications
        for medSection in MedicationController.shared.sections {
            for medication in medSection {
                MedicationController.shared.deleteMedication(medication)
            }
        }
    }
    
    func testCreateMedication() {
        MedicationController.shared.createMedication(name: "Med1", timeOfDay: Date())
        MedicationController.shared.createMedication(name: "Med2", timeOfDay: Date())
        
        XCTAssertTrue(MedicationController.shared.notTakenMeds.count == 2)
        
    }
    
    func testUpdateMedicationDetails() {
        // Create mock data
        MedicationController.shared.createMedication(name: "Med1", timeOfDay: Date())
        
        // Call the function
        if let medToUpdate = MedicationController.shared.notTakenMeds.first(where: { medication in
            medication.name == "Med1"
        }) {
            MedicationController.shared.updateMedicationDetails(medToUpdate, name: "MedUpdated", timeOfDay: Date())
            // Verify output
            XCTAssertTrue(medToUpdate.name == "MedUpdated")
        }
    }
    
    func testUpdateMedicationTakenStatus() throws {
        // Create mock data
        ["testMed1", "testMed2", "testMed3", "testMed4", "testMed5"].forEach { name in
            MedicationController.shared.createMedication(name: name, timeOfDay: Date())
        }
        
        // Call the function we're testing
        
        let firstMedToUpdate = try XCTUnwrap(MedicationController.shared.notTakenMeds.first)
        let secondMedToUpdate = try XCTUnwrap(MedicationController.shared.notTakenMeds.last)
        
        MedicationController.shared.updateMedicationTakenStatus(true, medication: firstMedToUpdate)
        MedicationController.shared.updateMedicationTakenStatus(true, medication: secondMedToUpdate)
        
        // Verify output
        XCTAssertTrue(MedicationController.shared.notTakenMeds.count == 3)
        XCTAssertTrue(MedicationController.shared.takenMeds.count == 2)
        
    }
    
    func testDeleteMedication() throws {
        // Create mock data
        ["testMed1", "testMed2", "testMed3", "testMed4", "testMed5"].forEach { name in
            MedicationController.shared.createMedication(name: name, timeOfDay: Date())
        }
        
        let firstMedToDelete = try XCTUnwrap(MedicationController.shared.notTakenMeds.first)
        let secondMedToDelete = try XCTUnwrap(MedicationController.shared.notTakenMeds.last)
        
        // Call delete function
        
        MedicationController.shared.deleteMedication(firstMedToDelete)
        MedicationController.shared.deleteMedication(secondMedToDelete)
        
        // Verify expected functionality
        XCTAssertTrue(MedicationController.shared.notTakenMeds.count == 3)
        
        let containsDeletedMeds = MedicationController.shared.notTakenMeds.contains { medication in
            medication.name == "testMed1" || medication.name == "testMed5"
        }
        
        XCTAssertFalse(containsDeletedMeds)
    }

}
