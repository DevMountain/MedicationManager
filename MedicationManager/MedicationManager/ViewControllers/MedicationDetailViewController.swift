//
//  MedicationDetailViewController.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 12/21/20.
//

import UIKit

class MedicationDetailViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!

    var medication: Medication?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let medication = medication,
           let timeOfDay = medication.timeOfDay {
            nameTextField.text = medication.name
            datePicker.date = timeOfDay

            title = "Medication Details"
        } else {
            title = "Add Medication"
        }
    }
    
    @IBAction func saveMedicationButtonTapped(_ sender: UIBarButtonItem) {
        guard let name = nameTextField.text,
              !name.isEmpty
        else { return }

        if let medication = medication {
            MedicationController.shared.updateMedicationDetails(medication, name: name, timeOfDay: datePicker.date)
        } else {
            MedicationController.shared.createMedication(name: name, timeOfDay: datePicker.date)
        }

        navigationController?.popViewController(animated: true)
    }

}
