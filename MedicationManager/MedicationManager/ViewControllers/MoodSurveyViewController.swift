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

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(reminderFired), name: Notification.Name(Strings.reminderReceivedNotificationName), object: nil)
    }

    @objc func reminderFired() {
        view.backgroundColor = .systemRed
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.view.backgroundColor = .systemPurple
        }
    }

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
