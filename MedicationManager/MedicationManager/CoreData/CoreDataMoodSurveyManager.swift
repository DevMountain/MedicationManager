//
//  CoreDataMoodSurveyManager.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 2/16/24.
//

import CoreData

class CoreDataMoodSurveyManager: MoodSurveyManaging {
    
    func fetchTodaysMoodSurvey() -> MoodSurvey? {
        guard let todaysCDMoodSurvey = fetchTodaysCDMoodSurvey(),
              let mentalState = todaysCDMoodSurvey.mentalState,
              let date = todaysCDMoodSurvey.date
        else { return nil }
        
        return MoodSurvey(mentalState: mentalState, date: date)
    }
    
    func recordSurveyResponse(_ moodEmoji: String) {
        CDMoodSurvey(mentalState: moodEmoji, date: Date())
        CoreDataStack.saveContext()
    }

    func updateTodaysMoodSurvey(moodEmoji: String) {
        guard var todaysSurvey = fetchTodaysMoodSurvey()
        else { return }
        
        todaysSurvey.mentalState = moodEmoji
        CoreDataStack.saveContext()
    }
    
    // MARK: - Private
    
    private lazy var todaysMoodSurveyFetchRequest: NSFetchRequest<CDMoodSurvey> = {
        let request = NSFetchRequest<CDMoodSurvey>(entityName: Strings.moodSurveyEntityType)
        let startOfToday = Calendar.current.startOfDay(for: Date())
        let endOfToday = Calendar.current.date(byAdding: .day, value: 1, to: startOfToday) ?? Date()
        let afterPredicate = NSPredicate(format: "date > %@", startOfToday as NSDate)
        let beforePredicate = NSPredicate(format: "date < %@", endOfToday as NSDate)
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [afterPredicate, beforePredicate])
        return request
    }()

    private func fetchTodaysCDMoodSurvey() -> CDMoodSurvey? {
        return ((try? CoreDataStack.context.fetch(todaysMoodSurveyFetchRequest)) ?? []).first
    }
}
