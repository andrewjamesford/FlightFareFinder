//
//  RegistrationForm.swift
//  SwiftExample
//
//  Created by Nick Lockwood on 29/09/2014.
//  Copyright (c) 2014 Nick Lockwood. All rights reserved.
//

import UIKit


class SettingsForm: NSObject, FXForm {

    var origin: String?
    var destination: String?
    var alertAmount = 0
    var dateFrom: NSDate?
    var notificationsEnabled = false
    let airports = ["AKL", "TRG", "WLG", "CHC", "ZQN", "HLZ"]
        
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
                FXFormFieldOptions: [49, 59, 69, 79, 89, 99, 109]],
            
            [FXFormFieldKey: "dateFrom",
                FXFormFieldTitle: "Notify From"],
            
            [FXFormFieldTitle: "Save", FXFormFieldHeader: "", FXFormFieldAction: "submitSettingsForm:"],
        ]
    }
}
