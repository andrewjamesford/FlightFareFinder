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
    let userDefaults = UserService.loadUserSettings()
    let myUrl = getConfigProperty("BookingURL")
    
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
        
        print("loadfares")
        refreshControl?.addTarget(self, action: "refreshFares", forControlEvents: UIControlEvents.ValueChanged)
        
        let segmentTitle1: String = orig + " ✈️ " + dest
        print(segmentTitle1)
        
        let segmentTitle2: String = dest + " ✈️ " + orig
        print(segmentTitle2)
        
        locationToggle.setTitle(segmentTitle1, forSegmentAtIndex: 0)
        locationToggle.setTitle(segmentTitle2, forSegmentAtIndex: 1)
        
        GASService.getPrices(origin, destination: destination) { (JSON) -> () in
            self.fares = JSON["PriceAvailability"]
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    func openURL(url: String, date: NSDate) {
        
        let nextDay: NSDate = (date + 1.day)!
        
        let dateFormatterMonth = NSDateFormatter()
        dateFormatterMonth.dateFormat = "MMM"
        let urlMonthString: String = dateFormatterMonth.stringFromDate(date)
        let urlMonthStringNext: String = dateFormatterMonth.stringFromDate(nextDay)
        print(urlMonthString)
        print(urlMonthStringNext)
        
        let dateFormatterDay = NSDateFormatter()
        dateFormatterDay.dateFormat = "dd"
        let urlDayString: String = dateFormatterDay.stringFromDate(date)
        let urlDayStringNext: String = dateFormatterDay.stringFromDate(nextDay)
        print(urlDayString)
        print(urlDayStringNext)
        
        let params: String = "searchLegs%5B0%5D.originPoint=" + orig + "&searchLegs%5B0%5D.destinationPoint=" + dest + "&searchLegs%5B1%5D.originPoint=" + dest + "&searchLegs%5B1%5D.destinationPoint=" + orig + "&bookingClass=economy&searchLegs%5B0%5D.tripStartMonth=" + urlMonthString + "&searchLegs%5B0%5D.tripStartDate=" + urlDayString + "&searchLegs%5B1%5D.tripStartMonth=" + urlMonthStringNext + "&searchLegs%5B1%5D.tripStartDate=" + urlDayStringNext + "&searchType=flexible&tripType=return&promoCode=&gasToken=&productPreference=DS&displaySearchForFlight=true"
        let combinedUrl = url + "?" + params
        let targetURL = NSURL(string: combinedUrl)
        
        UIApplication.sharedApplication().openURL(targetURL!)

    }
    
    func loadUserDefaults()
    {
        print("loaduserdefaults")
        orig = userDefaults.origin!
        dest = userDefaults.destination!
        print(orig)
        print(dest)
    }
    

    @IBAction func swapLocationTouch(sender: AnyObject) {
        refreshFares()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadUserDefaults()
                    
        loadFares(orig, destination: dest)

    }
    
    override func viewDidAppear(animated: Bool) {

        loadUserDefaults()
        
        locationToggle.selectedSegmentIndex = 0
        
        loadFares(orig, destination: dest)
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

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

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let selectedFare = fares[indexPath.row]
        
        let fareDate = selectedFare["@outboundDate"].string ?? ""
        
        // Convert date to month and day paramerters
        if (fareDate != "")
        {
            let dateStringFormatter = NSDateFormatter()
            dateStringFormatter.dateFormat = "yyyy-MM-dd"
            dateStringFormatter.locale = NSLocale.currentLocale()
            let d = dateStringFormatter.dateFromString(fareDate)!
            
            openURL(myUrl, date: d)
        }
        
    }

}
