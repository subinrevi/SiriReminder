//
//  ListManager.swift
//  SiriReminder
//
//  Created by Subin Revi on 09/11/18.
//  Copyright © 2018 Subin Revi. All rights reserved.
//

import Foundation


class ListManager {
    
    private var reminderList = [String]()
    static let ReminderKey = "reminders"
    static let GroupId = "group.com.otis.SiriReminder"
    static let sharedInstance = ListManager()
    let sharedDefaults = UserDefaults(suiteName: ListManager.GroupId)
    
    //Initialises the ListManager class
    private init() {
        if let saved = sharedDefaults?.value(forKey:ListManager.ReminderKey) {
            reminderList = saved as! [String]
        }
        let library_path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]
        
        print("library path is \(library_path)")
    }
   
    //Add a reminder
    func addReminder(reminder:String){
        
        reminderList.append(reminder)
        sharedDefaults?.set(reminderList, forKey: ListManager.ReminderKey)
        sharedDefaults?.synchronize()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "Reminder Added"), object: nil, userInfo: nil)
       
        
    }
    
    //Show all the reminders
    func showMyReminders() -> [String] {
        
        guard let openReminders = sharedDefaults?.value(forKey: ListManager.ReminderKey) else {return ["Testing"]}

        return openReminders as! [String]

    }

    //Delete a reminder
    func deleteReminder(){
        
        reminderList.removeAll()
        sharedDefaults?.set(reminderList, forKey: ListManager.ReminderKey)
        sharedDefaults?.synchronize()
    }
    
   
}
