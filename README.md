MedicationManager

Day 1: Main Objective - Introduction to CoreData (CRU - Create Read Update)

- Show the finished product (End of day 1 of 4 )
- Everyone should start on the `starter` branch.
- Build view controllers one at a time on the storyboard.
- Create the corresponding swift file or each subclass of UIViewController and UITableViewCell created so that you can set up outlets and actions.
- Create the model controller `MedicationController` and stub out functions for CRUD methods. No parameters needed yet. 
(You should be about 1 hour into the lesson at this point)
- Now is a great time to talk through MVC. Show how the views will tell the view controllers about touch events and the VCs will have to tell another object (the Model Controller) to do something with the data. Show how it doesn’t matter how we store the data (I.e. CloudKit, Firebase, CoreData, etc…) this is an example of an MVC architecture with each object doing it’s specific job. But what about the Model? Well each backend persistence method you choose will have different requirements on how they want the data delivered to them and how you’ll get them out. So there will be some nuances you’ll have to learn for whichever method of persistence you choose. This week we’ll be talking about ONE WAY to store data. Core Data is a way of storing the user’s app data on their device. Now you can start teaching about how Core Data works. When appropriate start building out (or paste in) the CoreDataStack. Point out the key elements: Container, PersistentStore, and Context.
- Finally we’re back to the Model. Now show how to create the models (Entities) in the .xcdatamodeld file.
- Build out the `Medication+convenience` and further clarify how the managed objects need to be in a context before they can be saved to the persistent store.
(You should be around the 2 hour mark at this point)
- Take the necessary steps to create and save a Medication to CoreData.
- Write a fetch request to fetch all the Medications from CoreData and display them in the table view.
- Showing the timeOfDay will require us to build a DateFormatter. (Go over DateFormatter as in depth as you see fit)
- Implement the two different ways of getting to `MedicationDetailViewController` (Tapping the “+” or tapping an existing medication cell). 
- Implement  `updateMedicationDetails(medication:name:timeOfDay:)` in the MedicationController so that you can call it to update existing medications in the detail view.

Day 2: Objectives - Delegate review, CoreData Relationships, Sets, TableView Sections and nested arrays.

- Start out by discussing the user facing features we’ll be implementing today. (1- Be able to mark a medication as “taken”, 2- Separate Meds into sections in the tableView, Optional 3- Allow user to rate their wellness level for the day)
Objective - Mark a Medication as taken. (Delegate review, CoreData Relationships, Sets)
- Explain that we need to talk about how structure the code so we can tap the empty box to mark the medication as taken. Answer: Custom delegate. Students should have seen this before. See if they can help write it.
- Soon they’ll notice that we don’t have a place to store this data. We’ll be tracking the dates when the user marked the medication as taken. We will now introduce them to how CoreDate uses relationships between Model objects (Entities) to solve these types of things. (e.g. a Teacher having  a `var students: [Student]`) Instead of a parent having an array of children, CoreData uses `Sets`. Go and add the `TakenDate` Entity and set up the one-to-many relationship. Change the "Editor Style" to show them the entity object map view.
- Create `TakenDate+Convenience`. Note that you need to pass in the medication that it should be tied to. (i.e. it's parent)
- Now that the `TakenDate` exists we can go back to creating the delegate. Show how the cell will talk to the `MedicationListTableViewController` which will talk to the `MedicationController` which will be the object that actually creates a TakenDate (i.e. marks the medication as taken for that day).
- We’ll now need code to show the `hasTakenButton` with or without a checkmark based on if the medication was taken today or not. Make changes to the `MedicationTableViewCell`. Also, add and explain `func wasTakenToday() -> Bool` in the `Medication+Convenience`
(You should be around the 1 - 1.5 hour mark at this point)
Objective - Show table view sections using Nested Arrays
- Update the `MedicationController` to separate the meds into sections.
- Make changes to the tableView so that it can display the two sections. This is a great time to solidify their understanding of how the tableView works. An explanation of `IndexPath` is helpful in understanding how to display nested arrays. 
- Use `func titleForHeaderInSection` to add a title for each section. 
- You should now see the meds separated into sections.
- If you tap to mark a med as taken you’ll notice that they don’t move sections as they should. Let’s fix that now.
- Add logic to `MedicationController.updateMedicationTakenStatus` and `MedicationListViewController.medicationWasTakenTapped`.
- Everything should work at this point.
(You should be around the 2.5 hour mark)
Objective - 2nd example of a delegate (Possibly move to Day 3)
- Pull up an image of the view we are adding above the table view so that you can build it in the storyboard.
- After building the view. Wire up an action to the `MedicationListViewController`. Leave it blank for now.
- Now build the `MoodSurveyViewController`. Make sure it's presentation style is full screen. Create its associated .swift file and wire up its two actions. Show how different buttons can use the same action. Add tags to the buttons to differentiate them. Add a print statement in the buttonTapped action and run the app to show how you’ll know which button was tapped based on its tag.
- We’ll present this view controller programmatically from the action we created earlier. Remember to make sure it's presentation style is full screen. Get this working and run the app.
- Now we see that we need to let the `MedicationListViewController` know when the user taps an emoji and which one they tapped.
- Let’s create another delegate. Students will have done this several times at this point in the program. Try to solidify their understanding of delegates. This will be a good time to identify the students that are struggling with the concept to know who needs more help.
- The emoji in the `MedicationListViewController` should change to the user’s selection.
- **The next part is optional**. You can get the delegate working and stop there. It doesn’t need to persist to understand how the delegate works. If you have extra time and you’d like to persist their mood survey choice we can go through the steps.
- Explain that we need a new Entity to keep track of this survey. Create the `MoodSurvey` entity and add its attributes.
- Create `MoodSurvey+Convenience`
- Create `MoodSurveyController` and add its CRU (No Delete needed) functions and properties including the fetchRequest.
- Call each function in the appropriate place.

Day 3:

- Start by showing off today’s finished product. (Day 3 of 4) Explain that we will be adding Local Notifications to remind the user when to take their meds.
- Explain (possibly show the documentation) that we can’t just show the user notifications without their permission. We first need to ask for it. Implement the request in the `AppDelegate`. You could talk about the point made in the documentation that it is better for the user if you wait to request permission until they create their first reminder. That way they will have more context into why they could benefit from notifications. For simplicity’s sake, we’ll handle this in `AppDelegate`.
- Create a class called `NotificationScheduler`. This will help keep a “separation of concerns”. Stub out its two functions.
- Before building out the function bodies. As a group, see if the students can think of where and when they’d call these functions. Help as needed and call the functions in the correct places.
- Import `UserNotifications` and implement the functions to be able to schedule and cancel notifications.
- Stop when you hit the point of needing an identifier for the notification. Talk about how almost always, our model objects will benefit from having an `id` property to uniquely identify it throughout our app and database.
- Go to the `Medication` entity and add the `id` attribute. Add a default value in `Medication+Convenience`. If you run the app it will crash. Instead of migrating to the new schema let’s just delete the app from our simulator to clear out any medications we have created with the old schema. Run it again and it should work.
- Back to the creating of notifications. Now use the `medication.id.uuidString` for the identifier. Also, implement `clearNotifications(for:)`.
- Make sure these functions are being called where they are supposed to and test it out. Notifications should be working.
- If you haven’t added the functionality to delete a medication you could do that now. Make sure and change the delete rule to “Cascade” on the relationship takenDates.
    BONUS ROUND: (Going deeper into LocalNotifications)
- Let’s start by creating a `Strings` file to hold all of our string constants. No more magic strings. Go through the app and create constants for each magic string.
- In the `AppDelegate` we need to adopt the `UNUserNotificationCenterDelegate` and implement `func userNotificationCenter(_ center: didReceive response:, withCompletionHandler completionHandler:)`
- Make sure to make `AppDelegate` the UNUserNotificationCenter’s delegate (`UNUserNotificationCenter.current().delegate = self`)
- Jump over to `NotificationScheduler` we need to update the content’s userInfo to send the `medication.id` and set the `categoryIndentifier`.
- In `AppDelegate` create and set the category and actions. 
- Now implement `didReceive response` to mark the medication as taken if the user selects that action.
- You’ll also need to add a function to the `MedicationController` to make and save the update. 

Day 4: (NotificationCenter vs. Delegate Pattern)

- Start by discussing that in Object Oriented Programming we have a need to be able to pass data around the app. We have the need for different objects to be able to communicate to each other. Developers have developed several communication patterns over the years. A lot of these patterns are used in all sorts of programming languages. They aren't unique to iOS development. Each one has its pros and cons. As time passes you’ll learn more and more which tool to reach for in any given circumstance. Today we’ll be discussing a new pattern you haven’t seen yet. Delegates work well when you have a one-to-one communication need. Sometimes you want more than one “receiver” to know when an object sends out a message. The pattern we’ll go over today is one way of doing just that. (Combine is our newest tool for handling these sorts of things)
- We’re going to do something kind of random to demonstrate this. The goal is for the students to understand the concept.
- Talk through how we are going to create a situation where one object is going to send out a message and anyone that wants to listen for that message can “tune in”. 
- Now that we are going to jump into the code, make a **BIG EMPHASIS** on the fact that they are learning two different things that have similar names. (NOTIFICATIONCENTER != UNUSERNOTIFICATIONCENTER) 
- Let’s head to `AppDelegate`. If you haven’t already done the bonus from the last section we’ll need to adopt the `UNUserNotificationCenterDelegate`. Add  `func userNotificationCenter(_ center:, willPresent notification:, withCompletionHandler completionHandler:)`
- In this function we are going to “post” or send the message. Use the post method that takes a `Notification.Name`. The observer will need to use this same name.
- All 3 of our View Controllers should `observe` this notification. 
- Start out by adding a print statement in each VC that prints something unique like the VC name that is receiving the message. We want to show how all 3 VCs receive the notification.
- Change those print statements to change each of the VCs' background Color temporarily to red then back to what they were.
- Make sure to make `AppDelegate` is the delegate of the UNUserNotificationCenter (`UNUserNotificationCenter.current().delegate = self`)
- Run the app and test out the features. Everything should work. Fix anything that doesn’t.
