//
//  DateFormatter+Extras.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 12/22/20.
//

import Foundation

extension DateFormatter {

    static let shortTimeStyle: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()

}
