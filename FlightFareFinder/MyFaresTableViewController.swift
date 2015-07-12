//
//  MyFaresTableViewController.swift
//  FlightFareFinder
//
//  Created by Andrew Ford on 5/07/15.
//  Copyright © 2015 Andrew Ford. All rights reserved.
//

import UIKit

class MyFaresTableViewController: UITableViewController {

    var fares: JSON! = []
    var faresReturn: JSON! = []
    var orig: String = "TRG"
    var dest: String = "AKL"
    let userDefaults = NSUserDefaults.standardUserDefaults()
    let myUrl = "https://flightbookings.grabaseat.co.nz/vbook/actions/ext-search"
//    let myUrl = "https://flightbookings.grabaseat.co.nz"
//    let myUrl = "https://flightbookings.grabaseat.co.nz/vbook/actions/mobi/search?utm_medium=iPhone&utm_campaign=MLF&utm_source=gas"
    @IBOutlet weak var locationToggle: UISegmentedControl!
        
    func refreshFares() {
        switch(locationToggle.selectedSegmentIndex) {
        case 0:
            loadFares(orig, destination: dest)
        case 1:
            loadFares(dest, destination: orig)
        default:
            loadFares(orig, destination: dest)
        }
    }
    
    func loadFares(origin: String, destination: String) {
        GASService.getPrices(origin, destination: destination) { (JSON) -> () in
            self.fares = JSON["PriceAvailability"]
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    func openURL(url: String, month: String, day: String) {
        
        let params: String = "searchLegs%5B0%5D.originPoint=" + orig + "&searchLegs%5B0%5D.destinationPoint=" + dest + "&searchLegs%5B1%5D.originPoint=" + dest + "&searchLegs%5B1%5D.destinationPoint=" + orig + "&bookingClass=economy&searchLegs%5B0%5D.tripStartMonth=" + month + "&searchLegs%5B0%5D.tripStartDate=" + day + "&searchLegs%5B1%5D.tripStartMonth=" + month + "&searchLegs%5B1%5D.tripStartDate=" + day + "&searchType=flexible&tripType=return&promoCode=&gasToken=&productPreference=DS&displaySearchForFlight=true"
        let combinedUrl = url + "?" + params
        let targetURL = NSURL(string: combinedUrl)
        UIApplication.sharedApplication().openURL(targetURL!)

    }
    
//    func dateAdd()
//    {
//        let userCalendar = NSCalendar.currentCalendar()
//        
//        let flightDayComponents = NSDateComponents()
//        flightDayComponents.year = 2015
//        flightDayComponents.month = 2
//        flightDayComponents.day = 14
//        let flightDay = userCalendar.dateFromComponents(flightDayComponents)!
//        
//        let dayCalendarUnit: NS = .NSCalendarUnitDay
//        
//        let tenDaysFromNow = userCalendar.dateByAddingUnit(
//            dayCalendarUnit,
//            value: 1,
//            toDate: NSDate(),
//            options: nil)!
//        
//
//    
//    }
    
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
    

    @IBAction func swapLocationTouch(sender: AnyObject) {
        refreshFares()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUserDefaults()
                    
        loadFares(orig, destination: dest)
        
        let segmentTitle1: String = orig + " > " + dest
        let segmentTitle2: String = dest + " > " + orig
        
        locationToggle.setTitle(segmentTitle1, forSegmentAtIndex: 0)
        locationToggle.setTitle(segmentTitle2, forSegmentAtIndex: 1)
        
        refreshControl?.addTarget(self, action: "refreshFares", forControlEvents: UIControlEvents.ValueChanged)

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

    /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    */

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fares.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyFaresCell") as! MyFaresTableViewCell
        
        let fare = fares[indexPath.row]
        
        // Configure the cell...
        cell.configureWithMyFare(fare)

        
        return cell


    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let selectedFare = fares[indexPath.row]
        
        let fareDate = selectedFare["@outboundDate"].string ?? ""
        
        // Convert date to month and day paramerters
        
        openURL(myUrl, month: "Oct", day: "6")

    }
    
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

    /*
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

    }
    */


}
