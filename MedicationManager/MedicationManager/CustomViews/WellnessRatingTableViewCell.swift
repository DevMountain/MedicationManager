//
//  WellnessRatingTableViewCell.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 12/21/20.
//

import UIKit

class WellnessRatingTableViewCell: UITableViewCell {

    @IBOutlet weak var surveyButton: UIButton!

    @IBAction func surveyButtonTapped(_ sender: UIButton) {
        print("Survey Button Tapped")
    }

}
