//
//  MoodSurveyController.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 12/30/20.
//

import CoreData

class MoodSurveyController {

    static let shared = MoodSurveyController()

    private lazy var fetchRequest: NSFetchRequest<MoodSurvey> = {
        let request = NSFetchRequest<MoodSurvey>(entityName: Strings.moodSurveyEntityType)
        let startOfToday = Calendar.current.startOfDay(for: Date())
        let endOfToday = Calendar.current.date(byAdding: .day, value: 1, to: startOfToday) ?? Date()
        let afterPredicate = NSPredicate(format: "date > %@", startOfToday as NSDate)
        let beforePredicate = NSPredicate(format: "date < %@", endOfToday as NSDate)
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [afterPredicate, beforePredicate])
        return request
    }()

    var todaysMoodSurvey: MoodSurvey?

    func didTapMoodEmoji(_ emoji: String) {
        if let currentSurvey = todaysMoodSurvey {
            update(moodSurvey: currentSurvey, moodEmoji: emoji)
        } else {
            create(moodEmoji: emoji)
        }
    }

    func fetchTodaysMoodSurvey() {
        let todaysMoodSurvey = ((try? CoreDataStack.context.fetch(fetchRequest)) ?? []).first
        self.todaysMoodSurvey = todaysMoodSurvey
    }

    private func create(moodEmoji: String) {
        let moodSurvey = MoodSurvey(mentalState: moodEmoji, date: Date())
        todaysMoodSurvey = moodSurvey
        CoreDataStack.saveContext()
    }

    private func update(moodSurvey: MoodSurvey, moodEmoji: String) {
        moodSurvey.mentalState = moodEmoji
        CoreDataStack.saveContext()
    }

}
