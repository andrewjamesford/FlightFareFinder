//
//  MyFaresTableViewController.swift
//  FlightFareFinder
//
//  Created by Andrew Ford on 5/07/15.
//  Copyright © 2015 Andrew Ford. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SafariServices

class MyFaresTableViewController: UITableViewController {

    var fares: JSON! = []
    var faresReturn: JSON! = []
    var orig: String = "TRG"
    var dest: String = "AKL"
    let userDefaults = NSUserDefaults.standardUserDefaults()

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
    
    internal func loadFares(origin: String, destination: String) {
        print("loadfares")
        let segmentTitle1: String = orig + " ✈️ " + dest
        print(segmentTitle1)
        let segmentTitle2: String = dest + " ✈️ " + orig
        print(segmentTitle2)
        
        locationToggle.setTitle(segmentTitle1, forSegmentAtIndex: 0)
        locationToggle.setTitle(segmentTitle2, forSegmentAtIndex: 1)
        
        let baseURL = getConfigProperty("BaseURL")
        let urlString = baseURL + GASService.ResourcePath.Prices(origin: origin, destination: destination).description
        print("urlstring=" + urlString)
        
        Alamofire.request(.GET, urlString)
            .responseJSON { request, response, result in
                print(result)
                debugPrint(result)
    
                switch result {
                    case .Success(let data):
                        let json = JSON(data)
                        self.fares = json["PriceAvailability"]
                        self.tableView.reloadData()
                        self.refreshControl?.endRefreshing()
                    
                    case .Failure(_, let error):
                        print("Request failed with error: \(error)")
                }
        }
    }
    
    func openURL(url: String, date: NSDate) {
        
        let today = NSDate()
        let nextDay = NSCalendar.currentCalendar().dateByAddingUnit(
            .Day,
            value: 1,
            toDate: today,
            options: NSCalendarOptions(rawValue: 0))
        
        let dateFormatterMonth = NSDateFormatter()
        dateFormatterMonth.dateFormat = "MMM"
        let urlMonthString: String = dateFormatterMonth.stringFromDate(date)
        let urlMonthStringNext: String = dateFormatterMonth.stringFromDate(nextDay!)
        print(urlMonthString)
        print(urlMonthStringNext)
        
        let dateFormatterDay = NSDateFormatter()
        dateFormatterDay.dateFormat = "dd"
        let urlDayString: String = dateFormatterDay.stringFromDate(date)
        let urlDayStringNext: String = dateFormatterDay.stringFromDate(nextDay!)
        print(urlDayString)
        print(urlDayStringNext)
        
        let params: String = "searchLegs%5B0%5D.originPoint=" + orig + "&searchLegs%5B0%5D.destinationPoint=" + dest + "&searchLegs%5B1%5D.originPoint=" + dest + "&searchLegs%5B1%5D.destinationPoint=" + orig + "&bookingClass=economy&searchLegs%5B0%5D.tripStartMonth=" + urlMonthString + "&searchLegs%5B0%5D.tripStartDate=" + urlDayString + "&searchLegs%5B1%5D.tripStartMonth=" + urlMonthStringNext + "&searchLegs%5B1%5D.tripStartDate=" + urlDayStringNext + "&searchType=flexible&tripType=return&promoCode=&gasToken=&productPreference=DS&displaySearchForFlight=true"
        let combinedUrl = url + "?" + params
        let targetURL = NSURL(string: combinedUrl)
        
        
        if #available(iOS 9.0, *) {
            // Safari view controller
            let vc = SFSafariViewController(
                URL: targetURL!,
                entersReaderIfAvailable: false
            )
            vc.view.tintColor = getAppColor()
            presentViewController(vc, animated: true, completion: nil)
            
        } else {
            // Fallback on earlier versions
            UIApplication.sharedApplication().openURL(targetURL!)
        }
        
        

    }
    
    func loadUserDefaults()
    {
        print("loaduserdefaults")
        if ((userDefaults.objectForKey("orig") as? String) != nil)
        {
            orig = (userDefaults.objectForKey("orig") as? String)!
            print(orig)
        }
        if ((userDefaults.objectForKey("dest") as? String) != nil)
        {
            dest = (userDefaults.objectForKey("dest") as? String)!
            print(dest)
        }
    }
    

    @IBAction func swapLocationTouch(sender: AnyObject) {
        refreshFares()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //loadUserDefaults()
                    
        //loadFares(orig, destination: dest)
        
        refreshControl?.addTarget(self, action: "refreshFares", forControlEvents: UIControlEvents.ValueChanged)

    }
    
    override func viewDidAppear(animated: Bool) {
        
        print("View appeared")
        FareNotifications.sharedInstance.setBadgeNumbers(0)

        // super.viewDidAppear(<#T##animated: Bool##Bool#>)
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
