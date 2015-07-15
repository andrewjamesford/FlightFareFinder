//
//  SettingsViewController.swift
//  FlightFareFinder
//
//  Created by Andrew Ford on 11/07/15.
//  Copyright © 2015 Andrew Ford. All rights reserved.
//

import UIKit

class SettingsViewController: FXFormViewController {

    override func awakeFromNib() {
        
        formController.form = SettingsForm()
    }

    func submitRegistrationForm(cell: FXFormFieldCellProtocol) {
        
        //we can lookup the form from the cell if we want, like this:
        let form = cell.field.form as! SettingsForm
        
        //we can then perform validation, etc
        /*
        if form.agreedToTerms {
            
            UIAlertView(title: "Registration Form Submitted", message: "", delegate: nil, cancelButtonTitle: "OK").show()
            
        } else {
            
            UIAlertView(title: "User Error", message: "Please agree to the terms and conditions before proceeding", delegate: nil, cancelButtonTitle: "OK", otherButtonTitles: "Yes Sir!").show()
        }
        */
    }


}
