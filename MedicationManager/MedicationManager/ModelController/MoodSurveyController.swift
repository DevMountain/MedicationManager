//
//  MoodSurveyController.swift
//  MedicationManager
//
//  Created by Aaron Martinez on 12/30/20.
//

protocol MoodSurveyManaging {
    func recordSurveyResponse(_ moodEmoji: String)
    func fetchTodaysMoodSurvey() -> MoodSurvey?
    func updateTodaysMoodSurvey(moodEmoji: String)
}

class MoodSurveyController {

    static let shared = MoodSurveyController()
    private var moodSurveyManager: MoodSurveyManaging = CoreDataMoodSurveyManager()

    var todaysMoodSurvey: MoodSurvey?
    
    func fetchTodaysMoodSurvey() {
        self.todaysMoodSurvey = moodSurveyManager.fetchTodaysMoodSurvey()
    }
    
    func didTapMoodEmoji(_ emoji: String) {
        if todaysMoodSurvey != nil {
            moodSurveyManager.updateTodaysMoodSurvey(moodEmoji: emoji)
        } else {
            moodSurveyManager.recordSurveyResponse(emoji)
        }
    }
    
}
