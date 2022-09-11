//
//  SessionManager.swift
//  DemoVideo
//
//  Created by J.Sarath Krishnaswamy on 11/09/22.
//

import Foundation
import UIKit
class SessionManager: NSObject {
    
    

    static let sharedInstance = SessionManager()
    ///This method is used to save the firebase 'verification id' while login with mobile number
    
    ///This method is used to save the user login details
    var isDataStored : Bool{
        get {
            return UserDefaults.standard.object(forKey: "isDataStored") as? Bool != nil ? UserDefaults.standard.object(forKey: "isDataStored") as? Bool ?? false : false
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "isDataStored")
            defaults.synchronize()
        }
    }
   
    
    
  
}
