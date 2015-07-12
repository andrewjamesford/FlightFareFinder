//
//  SettingsTableViewController.swift
//  FlightFareFinder
//
//  Created by Andrew Ford on 9/07/15.
//  Copyright © 2015 Andrew Ford. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    var orig: String = "TRG"
    var dest: String = "AKL"
    let airportsNames = ["Auckland", "Tauranga"]
    let airportsKeys = ["AKL", "TGA"]
    let airports = ["Auckland":"AKL", "Tauranga":"TGA"]

    var settingsList: JSON = [
        [
            "title": "Origin",
            "key": "orig",
            "detail": "TGA",
            "type": "airport"
        ],
        [
            "title": "Destination",
            "key": "dest",
            "detail": "AKL",
            "type": "airport"
        ],
        [
            "title": "Alert amount",
            "key": "amount",
            "detail": "$49",
            "type": "amount"
        ],
        [
            "title": "Date from",
            "key": "dateFrom",
            "detail": "1/Dec/2015",
            "type": "date"
        ]

    ]
    

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
    
    func populateFields()
    {
        //origText.text = orig
        //destText.text = dest
    }
    
    func saveUserDefaults(origText: String, destText: String)
    {
        userDefaults.setObject(origText, forKey: "orig")
        userDefaults.setObject(destText, forKey: "dest")
        
        userDefaults.synchronize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //airportPicker.hidden = false
        
        loadUserDefaults()

        populateFields()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return settingsList.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("SettingsCell") as! SettingsTableViewCell!

        // Configure the cell...
        let setting = settingsList[indexPath.row]
        
        cell.configureWithSetting(setting)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ViewSettingsDetail"{
            let vc = segue.destinationViewController as! SettingsViewController

        }
    }
    

}
