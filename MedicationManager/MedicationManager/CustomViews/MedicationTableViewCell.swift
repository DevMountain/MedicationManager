//
//  MedicationTableViewCell.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 12/21/20.
//

import UIKit

protocol MedicationCellDelegate: AnyObject {
    func medicationWasTakenTapped(wasTaken: Bool, medication: Medication, cell: MedicationTableViewCell)
}

class MedicationTableViewCell: UITableViewCell {

    weak var delegate: MedicationCellDelegate?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dosageTimeLabel: UILabel!
    @IBOutlet weak var hasTakenButton: UIButton!

    var medication: Medication?
    private var wasTakenToday: Bool = false

    @IBAction func hasTakenButtonTapped(_ sender: UIButton) {
        guard let medication = medication
        else { return }

        wasTakenToday.toggle()
        delegate?.medicationWasTakenTapped(wasTaken: wasTakenToday, medication: medication, cell: self)
    }

    func configure(with medication: Medication) {
        self.medication = medication
        wasTakenToday = medication.wasTakenToday()

        titleLabel.text = medication.name
        dosageTimeLabel.text = medication.timeOfDay.formatted(date: .omitted, time: .shortened)
        let image = wasTakenToday ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
        hasTakenButton.setImage(image, for: .normal)
        hasTakenButton.tintColor = .black
    }

    override func prepareForReuse() {
        super.prepareForReuse()

        medication = nil
        wasTakenToday = false
    }
}
