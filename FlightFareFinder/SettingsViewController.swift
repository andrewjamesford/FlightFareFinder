//
//  SettingsViewController.swift
//  FlightFareFinder
//
//  Created by Andrew Ford on 11/07/15.
//  Copyright © 2015 Andrew Ford. All rights reserved.
//

import UIKit
import FXForms

class SettingsViewController: FXFormViewController {
    
    let userDefaults = UserService.loadUserSettings()
    var orig: String?
    var dest: String?
    var alertAmount = 0
    var dateFrom: NSDate?
    var notificationsEnabled = false
    
    override func awakeFromNib() {

        formController.form = SettingsForm()
        
        reloadForm()
        
    }
    
    func reloadForm() {
        
        let form = formController.form as! SettingsForm
        form.origin = userDefaults.origin
        form.destination = userDefaults.destination
        form.dateFrom = userDefaults.dateFrom
        form.alertAmount = userDefaults.alertAmount
        form.notificationsEnabled = userDefaults.notificationsEnabled
        
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

        if (!formLocationValid)
        {
            UIAlertView(title: "Locations", message: "Please select all locations", delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        
        if (form.notificationsEnabled) {
            if (!formNotificationValid)
            {
                UIAlertView(title: "Notifications", message: "Please enter an amount and date", delegate: nil, cancelButtonTitle: "OK").show()
                return
            }
        }
        
        UserService.setUserSettings(form.origin, destination: form.destination, alertAmount: form.alertAmount, dateFrom: form.dateFrom, notificationsEnabled: form.notificationsEnabled)
        
        UIAlertView(title: "Settings", message: "Saved", delegate: nil, cancelButtonTitle: "OK").show()
        return

    }


}
