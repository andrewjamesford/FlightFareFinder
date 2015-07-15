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
    var alertAmount: Int = 0
    var dateFrom: NSDate?
    
    
    enum Airports: String {
        case Auckland = "AKL"
        case Tauranga = "TGA"
        case Wellington = "WGN"
    }
    
    
    
    //because we want to rearrange how this form
    //is displayed, we've implemented the fields array
    //which lets us dictate exactly which fields appear
    //and in what order they appear
        
    func fields() -> [AnyObject]! {
        
        return [
            
            [FXFormFieldKey: "origin",
                FXFormFieldTitle: "Origin",
                FXFormFieldOptions: ["Auckland", "Tauranga", "Wellington"],
                FXFormFieldCell: FXFormOptionPickerCell.self],
            
            [FXFormFieldKey: "destination",
                FXFormFieldTitle: "Destination",
                FXFormFieldOptions: ["Auckland", "Tauranga", "Wellington"],
                FXFormFieldCell: FXFormOptionPickerCell.self],
            
            
            [FXFormFieldKey: "alertAmount",
                FXFormFieldTitle: "Alert Amount",
                FXFormFieldOptions: ["$49", "$59", "$69", "$79", "$89", "$99", "$109"],
                FXFormFieldCell: FXFormOptionPickerCell.self],
            
            "dateFrom",
            
            //this field doesn't correspond to any property of the form
            //it's just an action button. the action will be called on first
            //object in the responder chain that implements the submitForm
            //method, which in this case would be the AppDelegate
            
            [FXFormFieldTitle: "Submit", FXFormFieldHeader: "", FXFormFieldAction: "submitRegistrationForm:"],
        ]
    }
}
