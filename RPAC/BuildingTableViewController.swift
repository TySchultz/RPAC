//
//  BuildingTableViewController.swift
//  RPAC
//
//  Created by Ty Schultz on 6/25/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import Mixpanel
import SafariServices

class BuildingTableViewController: UITableViewController {

    @IBOutlet weak var headerView: UIView!
    let SECTIONHEIGHT :CGFloat = 100

    @IBOutlet weak var loadingImage: UIImageView!
    @IBOutlet weak var headerConstraint: NSLayoutConstraint!
    var events : [[Event]]!
    var basketballEvents : [Event]!
    var downloadStatus = 0
    var buildings : [String]!
    var mixpanel : Mixpanel!
    
    var showLoading : Bool = false
    
    @IBOutlet weak var headerLogo: UIImageView!
    @IBOutlet weak var weekday: UILabel!
    @IBOutlet weak var monthDay: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = ""
        
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: false)
        
        events = [[]]
        basketballEvents = []
        buildings = []
        
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 85)

        tableView.reloadData()
        mixpanel = Mixpanel.sharedInstanceWithToken("YOUR_API_TOKEN")
        
        weekday.text = NSDate().weekday()
        monthDay.text = NSDate().month() + " \(NSDate().day())"
        
    
        headerLogo.layer.masksToBounds = true
        headerLogo.layer.cornerRadius = 16.0
        
        
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "backButton")
        self.navigationController?.navigationBar.tintColor = UIColor(red:0.12, green:0.71, blue:0.93, alpha:1.00)
        self.navigationController?.navigationBar.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        
      
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if showLoading {
            startLoading()
        }
    }
    
    
    func reloadData() {
        showLoading = true
        startLoading()
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
            let downloader = Downloader()
            (self.events,self.buildings,self.downloadStatus) = downloader.downloadSchedule()
            print(self.buildings)
            self.basketballEvents = downloader.findBasketballEvents(self.events)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if self.downloadStatus == 256 {
                   self.errorNoInternet()
                }
                self.tableView.reloadData()
                self.stopLoading()
            })
        })
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return basketballEvents.count + 1
        case 1:
            return buildings.count + 1
        default:
            return 2
        }
    }
    
 
    
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCellWithIdentifier("HeaderCell", forIndexPath: indexPath) as! HeaderTableViewCell
            
            switch indexPath.section {
            case 0:
                cell.sectionTitle.text = "BASKETBALL"
            case 1:
                cell.sectionTitle.text = "ALL BUILDINGS"
            case 2:
                cell.sectionTitle.text = "MORE"
            default:
                cell.sectionTitle.text = "BASKETBALL"
            }
            return cell
            
        }else{
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell
                
                let basketballEvent = basketballEvents[indexPath.row - 1]
                cell.timeLabel.text = basketballEvent.time
                cell.activityLabel.text = basketballEvent.activity
                cell.locationLabel.text = basketballEvent.location
                cell.buildingLabel.text = basketballEvent.building
                if basketballEvent.building == "Recreation and Physical Activity Center" {
                    cell.buildingLabel.text = "RPAC"
                }else if basketballEvent.building.containsString("Jesse Owens") {
                    var tmpString = basketballEvent.building
                    let myRange = tmpString.startIndex.advancedBy(0)..<tmpString.startIndex.advancedBy(11)
                    tmpString.removeRange(myRange)
                    cell.buildingLabel.text = "JO" + tmpString
                }
                
                cell.courtImage.image = cell.selectCourtImage(basketballEvent.location)
                
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("BuildingCell", forIndexPath: indexPath) as! BuildingCell
                
                let building = buildings[indexPath.row - 1]
                cell.buildingLabel.text = building
                let buildingEvents = events[indexPath.row - 1]
                cell.numberOfEvents.text = "\(buildingEvents.count) events"
                
                if building == "Recreation and Physical Activity Center" {
                    cell.buildingLabel.text = "RPAC"
                }
                return cell
            case 2:
                let cell = tableView.dequeueReusableCellWithIdentifier("CollectionCell", forIndexPath: indexPath) as! CollectionViewCell
                
                
                return cell
            default:
                let cell = tableView.dequeueReusableCellWithIdentifier("BuildingCell", forIndexPath: indexPath)
                return cell
            }
        }
    }
    
        
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 64.0
        }
        
        switch indexPath.section {
        case 0:
            return 128
        case 1:
            return 64.0
        case 2:
            return 160.0
        default:
            return 100.0
        }
        
    }
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed

        switch segue.identifier! {
            case "BuildingDetail":
                let detailController = segue.destinationViewController as! TableViewController
                detailController.events = events[tableView.indexPathForSelectedRow!.row-1]
                let headerText = buildings[tableView.indexPathForSelectedRow!.row-1]
                detailController.title = headerText
                if headerText == "Recreation and Physical Activity Center" {
                    detailController.title = "RPAC"
                }
                mixpanel.track(
                    "Building Selected",
                    properties: ["building name": buildings[tableView.indexPathForSelectedRow!.row-1]]
                )
            
            case "CourtKey":
                let detailController = segue.destinationViewController as! CourtKeyTableViewController
                detailController.title = "Court Key"
            default:
                print("this segue doesnt work")
        }
     }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        
        if offset < 0 {
            headerConstraint.constant = offset + 24
        }
    }
    
    
    @IBAction func shareButtonPressed(sender: TSButton) {
        
        self.mixpanel.track(
            "Share Pressed",
            properties: nil
        )
        
        let textToShare = "Check out RPAC basketball! An easy way to check which OSU courts are open for basketball! #RPAC"
        
            let objectsToShare = [textToShare]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            
            //New Excluded Activities Code
            //
            
            activityVC.popoverPresentationController?.sourceView = sender
            self.presentViewController(activityVC, animated: true, completion: nil)
    }
    @IBAction func checkInPressed(sender: TSButton) {
    
        let alert = UIAlertController(title: "Check in!", message: "If RPAC gets enough downloads a check in feature will be created. See how many people are playing from home.\n\n Are you interested?", preferredStyle: .Alert) // 1
        let firstAction = UIAlertAction(title: "Yes", style: .Default) { (alert: UIAlertAction!) -> Void in
            self.mixpanel.track(
                "Check In",
                properties: ["Answer" : "YES"]
            )
        } // 2
        
        let secondAction = UIAlertAction(title: "No", style: .Default) { (alert: UIAlertAction!) -> Void in
            self.mixpanel.track(
                "Check In",
                properties: ["Answer" : "NO"]
            )
        } // 3
        
        alert.addAction(firstAction) // 4
        alert.addAction(secondAction) // 5
        presentViewController(alert, animated: true, completion:nil) // 6
        
    }
    
    @IBAction func websiteLink(sender: UIButton) {
        
        mixpanel.track(
            "website shown",
            properties: nil
        )
        
        let svc = SFSafariViewController(URL: NSURL(string: "http://recsports.osu.edu/schedule")!)
        svc.modalPresentationStyle = .OverFullScreen
        self.presentViewController(svc, animated: true, completion: nil)
        
        
        
    }
    
    
    func errorNoInternet(){
        let alert = UIAlertController(title: "Oops!", message: "Make sure you have internet to download the schedule", preferredStyle: .Alert) // 1
        let firstAction = UIAlertAction(title: "Retry", style: .Default) { (alert: UIAlertAction!) -> Void in
            self.reloadData()
        } // 2
        
        let secondAction = UIAlertAction(title: "Cancel", style: .Default) { (alert: UIAlertAction!) -> Void in
            print("SHIT")
        } // 3
        
        alert.addAction(firstAction) // 4
        alert.addAction(secondAction) // 5
        presentViewController(alert, animated: true, completion:nil) // 6
    }
    
    
    func startLoading(){
        self.loadingImage?.alpha = 0.0
        UIView.animateWithDuration(0.2, animations: {
            self.loadingImage?.alpha = 1.0
        }) { (Bool) in

        }
        var rotationAnimation = CABasicAnimation()
        rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue =  M_PI * 2.0 /* full rotation*/
        rotationAnimation.duration = 1.0;
        rotationAnimation.cumulative = true;
        rotationAnimation.repeatCount = 100;
        
        loadingImage?.layer.addAnimation(rotationAnimation, forKey: "rotationAnimation")
    }
    func stopLoading() {
        showLoading = false

        UIView.animateWithDuration(0.4, animations: {
            self.loadingImage.alpha = 0.0
            }) { (Bool) in
                self.loadingImage.layer.removeAllAnimations()
        }
    }
}

extension NSDate
{
    func month() -> String
    {
        //Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Month, fromDate: self)
        let month = components.month
        switch month {
        case 1:
            return "JANUARY"
        case 2:
            return "FEBRUARY"
        case 3:
            return "MARCH"
        case 4:
            return "APRIL"
        case 5:
            return "MAY"
        case 6:
            return "JUNE"
        case 7:
            return "JULY"
        case 8:
            return "AUGUST"
        case 9:
            return "SEPTEMBER"
        case 10:
            return "OCTOBER"
        case 11:
            return "NOVEMBER"
        case 12:
            return "DECEMBER"
        default:
            return "NODAY"
        }
        //Return Hour
        return "NO MONTH"
    }
    
    
    func day() -> Int
    {
        //Get Minute
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Day, fromDate: self)
        let day = components.day
        
        //Return Minute
        return day
    }
    
    func weekday() -> String {
        //Get Minute
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Weekday, fromDate: self)
        let weekday = components.weekday
        
        switch weekday {
        case 1:
            return "SUNDAY"
        case 2:
            return "MONDAY"
        case 3:
            return "TUESDAY"
        case 4:
            return "WEDNESDAY"
        case 5:
            return "THURSDAY"
        case 6:
            return "FRIDAY"
        case 7:
            return "SATURDAY"
        default:
            return "NODAY"
        }
        //Return Minute
        return "NODAY"
    }
    
    func toShortTimeString() -> String
    {
        //Get Short Time String
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        let timeString = formatter.stringFromDate(self)
        
        //Return Short Time String
        return timeString
    }
    
  
}
