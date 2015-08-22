//
//  RegistrationForm.swift
//  SwiftExample
//
//  Created by Nick Lockwood on 29/09/2014.
//  Copyright (c) 2014 Nick Lockwood. All rights reserved.
//

import UIKit
import FXForms

class SettingsForm: NSObject, FXForm {

    var origin: String?
    var destination: String?
    var alertAmount = 0
    var dateFrom: NSDate?
    var notificationsEnabled = false
    let airports = ["AKL", "TRG", "WLG", "CHC", "ZQN", "HLZ"]
    let btnColor = getAppColor()
        
    func fields() -> [AnyObject]! {
        
        return [
            
            [FXFormFieldKey: "origin",
                FXFormFieldHeader: "Locations",
                FXFormFieldTitle: "Origin",
                FXFormFieldOptions: airports],
            
            [FXFormFieldKey: "destination",
                FXFormFieldTitle: "Destination",
                FXFormFieldOptions: airports],
            
            [FXFormFieldKey: "notificationsEnabled",
                FXFormFieldHeader: "Notifications",
                FXFormFieldTitle: "Enabled",
                FXFormFieldType: FXFormFieldTypeBoolean],
            
            [FXFormFieldKey: "alertAmount",
                FXFormFieldTitle: "Alert Amount",
                FXFormFieldOptions: [50, 60, 70, 80, 90, 100, 110]],
            
            [FXFormFieldKey: "dateFrom",
                FXFormFieldTitle: "Notify From"],
            
            [FXFormFieldKey: "saveButton", FXFormFieldTitle: "Save", FXFormFieldHeader: "", FXFormFieldAction: "submitSettingsForm:", "backgroundColor": getAppColor(), "textLabel.color": UIColor.whiteColor() ],
            
            
        ]
    }
    
}
