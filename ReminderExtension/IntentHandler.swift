//
//  IntentHandler.swift
//  ReminderExtension
//
//  Created by Subin Revi on 09/11/18.
//  Copyright © 2018 Subin Revi. All rights reserved.
//

import Intents

class IntentHandler: INExtension {
    
   
}


extension IntentHandler:INCreateNoteIntentHandling {
    
    func resolveTitle(for intent: INCreateNoteIntent, with completion: @escaping (INSpeakableStringResolutionResult) -> Void) {
        let result: INSpeakableStringResolutionResult
        
        if let title = intent.title {
            result = INSpeakableStringResolutionResult.success(with: title)
        } else {
            result = INSpeakableStringResolutionResult.needsValue()
        }
        
        completion(result)
    }

    
    func resolveContent(for intent: INCreateNoteIntent, with completion: @escaping (INNoteContentResolutionResult) -> Void) {
        let result: INNoteContentResolutionResult
        
        if let content = intent.content {
            result = INNoteContentResolutionResult.success(with: content)
            
        } else {
            result = INNoteContentResolutionResult.notRequired()
        }
        
        completion(result)
    }
    
    func resolveGroupName(for intent: INCreateNoteIntent, with completion: @escaping (INSpeakableStringResolutionResult) -> Void) {
        
        let result: INSpeakableStringResolutionResult
        if let group = intent.groupName {
            result = INSpeakableStringResolutionResult.success(with: group)
        } else {
            result = INSpeakableStringResolutionResult.needsValue()
        }
        
        completion(result)
    }
    
    func confirm(intent: INCreateNoteIntent, completion: @escaping (INCreateNoteIntentResponse) -> Void) {
        completion(INCreateNoteIntentResponse(code: INCreateNoteIntentResponseCode.ready, userActivity: nil))

    }
    
    func handle(intent: INCreateNoteIntent, completion: @escaping (INCreateNoteIntentResponse) -> Void) {
        
        let response = INCreateNoteIntentResponse(code:.success, userActivity: nil)
        response.createdNote = INNote(title: intent.title!, contents: [], groupName: nil, createdDateComponents: nil, modifiedDateComponents: nil, identifier: nil)
        ListManager.sharedInstance.addReminder(reminder: (response.createdNote?.title.spokenPhrase)!)
        completion(response)
    }
    
}
