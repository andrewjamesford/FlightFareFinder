//
//  SettingsViewController.swift
//  FlightFareFinder
//
//  Created by Andrew Ford on 11/07/15.
//  Copyright © 2015 Andrew Ford. All rights reserved.
//

import UIKit

class SettingsViewController: FXFormViewController {
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    var orig: String?
    var dest: String?
    
    
    override func awakeFromNib() {

        formController.form = SettingsForm()
        
        reloadForm()
        
    }
    
    func reloadForm() {
        
        loadUserDefaults()
        
        let form = formController.form as! SettingsForm
        form.origin = orig
        form.destination = dest
        form.dateFrom = NSDate()
        form.alertAmount = 0
        
    }
    
    func loadUserDefaults()
    {
        if ((userDefaults.objectForKey("orig") as? String) != nil)
        {
            orig = (userDefaults.objectForKey("orig") as? String)!
        }
        if ((userDefaults.objectForKey("dest") as? String) != nil)
        {
            dest = (userDefaults.objectForKey("dest") as? String)!
        }
    }

    func submitSettingsForm(cell: FXFormFieldCellProtocol) {
        
        let form = cell.field.form as! SettingsForm
        var formLocationValid = true
        var formNotificationValid = true
        
        if (form.origin == "") {
            formLocationValid = false
        }
        else {
            orig = form.origin!
        }
        if (form.destination == "") {
            formLocationValid = false
        }
        else {
            dest = form.destination!
        }
        if (form.notificationsEnabled) {
            if (form.alertAmount == 0) { formNotificationValid = false }
            if (form.dateFrom == "") { formNotificationValid = false }
        }

        if (formLocationValid)
        {
            userDefaults.setValue(orig, forKey: "orig")
            userDefaults.setValue(dest, forKey: "dest")
        }
        else {
            UIAlertView(title: "Locations", message: "Please select all locations", delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        
        if (form.notificationsEnabled) {
            if (formNotificationValid) {
                userDefaults.setValue(form.notificationsEnabled, forKey: "notificationsEnabled")
                userDefaults.setValue(form.alertAmount, forKey: "alertAmount")
                userDefaults.setValue(form.dateFrom, forKey: "dateFrom")
            }
            else {
                UIAlertView(title: "Notifications", message: "Please enter and amount and date", delegate: nil, cancelButtonTitle: "OK").show()
                return
            }
        }
        
        UIAlertView(title: "Settings", message: "Saved", delegate: nil, cancelButtonTitle: "OK").show()
        return

    }


}
