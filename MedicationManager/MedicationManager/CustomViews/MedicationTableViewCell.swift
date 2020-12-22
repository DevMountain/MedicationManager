//
//  MedicationTableViewCell.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 12/21/20.
//

import UIKit

class MedicationTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dosageTimeLabel: UILabel!
    @IBOutlet weak var hasTakenButton: UIButton!

    @IBAction func hasTakenButtonTapped(_ sender: UIButton) {
        print("Has taken med tapped")
    }

    func configure(with medication: Medication) {
        titleLabel.text = medication.name
        dosageTimeLabel.text = DateFormatter.medicationTime.string(from: medication.timeOfDay ?? Date())
    }
}
