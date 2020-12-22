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

}
