//
//  MoodSurveyViewController.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 12/28/20.
//

import UIKit

protocol MoodSurveyViewControllerDelegate: class {
    func moodButtonTapped(with emoji: String)
}

class MoodSurveyViewController: UIViewController {

    weak var delegate: MoodSurveyViewControllerDelegate?

    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func moodButtonTapped(_ sender: UIButton) {
        guard let moodEmoji = sender.titleLabel?.text
        else { return }

        delegate?.moodButtonTapped(with: moodEmoji)
        dismiss(animated: true, completion: nil)
    }
}
