//
//  MedicationListViewController.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 12/21/20.
//

import UIKit

class MedicationListViewController: UIViewController {

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        MedicationController.shared.fetchMedications()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditMedication",
           let destination = segue.destination as? MedicationDetailViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            let medication = MedicationController.shared.medications[indexPath.row]
            destination.medication = medication
        }
    }

}

extension MedicationListViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MedicationController.shared.medications.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "medicationCell", for: indexPath) as? MedicationTableViewCell
        else { return UITableViewCell() }

        let medication = MedicationController.shared.medications[indexPath.row]

        cell.titleLabel.text = medication.name
        cell.dosageTimeLabel.text = dateFormatter.string(from: medication.timeOfDay ?? Date())
        return cell
    }
    
}
