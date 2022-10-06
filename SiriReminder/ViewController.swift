//
//  ViewController.swift
//  SiriReminder
//
//  Created by Subin Revi on 09/11/18.
//  Copyright © 2018 Subin Revi. All rights reserved.
//

import UIKit
import Intents

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var taskListTableView: UITableView!
    var reminderArray = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set("Testing standard user defaults ", forKey: "UserDefaults.Standard")
        // Ask permission to access Siri
        INPreferences.requestSiriAuthorization { authorizationStatus in
            switch authorizationStatus {
            case .authorized:
                print("Authorized")
            default:
                print("Not Authorized")
            }
        }
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(addedReminderToList), name:NSNotification.Name(rawValue: "Reminder Added"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        
    }
    
    // my selector that was defined above
    @objc func willEnterForeground() {
        taskListTableView.reloadData()
    }
    
    @objc func addedReminderToList(notfication: NSNotification) {
        taskListTableView.reloadData()
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if ListManager.sharedInstance.showMyReminders().count > 0 {
            return ListManager.sharedInstance.showMyReminders().count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = ListManager.sharedInstance.showMyReminders()[indexPath.row]
        return cell!
    }
    

   

}

