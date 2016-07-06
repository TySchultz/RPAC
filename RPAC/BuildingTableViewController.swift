//
//  BuildingTableViewController.swift
//  RPAC
//
//  Created by Ty Schultz on 6/25/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import Mixpanel
class BuildingTableViewController: UITableViewController {

    @IBOutlet weak var headerView: UIView!
    let SECTIONHEIGHT :CGFloat = 100

    var events : [[Event]]!
    var basketballEvents : [Event]!
    var buildings : [String]!
    var mixpanel : Mixpanel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        events = [[]]
        basketballEvents = []
        buildings = []
        
        let downloader = Downloader()
        (events,buildings) = downloader.downloadSchedule()
        print(buildings)
        basketballEvents = downloader.findBasketballEvents(events)
        
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 128)

        tableView.reloadData()
        mixpanel = Mixpanel.sharedInstanceWithToken("YOUR_API_TOKEN")
    }
    
    @IBAction func reloadData(sender: UIBarButtonItem) {
        let downloader = Downloader()
        (events,buildings) = downloader.downloadSchedule()
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
                cell.sectionTitle.text = "Basketball"
            case 1:
                cell.sectionTitle.text = "All Buildings, All Courts"
            case 2:
                cell.sectionTitle.text = "More"
            default:
                cell.sectionTitle.text = "Basketball"
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
                
                return cell
            case 1:
                let cell = tableView.dequeueReusableCellWithIdentifier("BuildingCell", forIndexPath: indexPath) as! BuildingCell
                
                let building = buildings[indexPath.row - 1]
                cell.buildingLabel.text = building
                let buildingEvents = events[indexPath.row - 1]
                cell.numberOfEvents.text = "\(buildingEvents.count) events"
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
            return 100.0
        case 1:
            return 64.0
        case 2:
            return 160.0
        default:
            return 100.0
        }
        
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
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        switch segue.identifier! {
        case "BuildingDetail":
            let detailController = segue.destinationViewController as! TableViewController
            detailController.events = events[tableView.indexPathForSelectedRow!.row-1]
            detailController.headerText = buildings[tableView.indexPathForSelectedRow!.row-1]
//            mixpanel.track(
//                "Building Selected",
//                properties: ["building name": buildings[tableView.indexPathForSelectedRow!.row-1]]
//            )
        case "CheckIn":
            let detailController = segue.destinationViewController as! CheckInTableViewController
        case "CourtKey":
            let detailController = segue.destinationViewController as! CourtKeyTableViewController
        default:
            print("this segue doesnt work")
        }
     // Get the snew view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
 
    @IBAction func basketballCellTapped(sender: UIButton) {
        
        let contentView = sender.superview
        let cell = contentView?.superview as! TableViewCell
    
        mixpanel.track(
            "Home Screen Court Selection",
            properties: ["time": cell.timeLabel.text!, "location": cell.locationLabel.text!]
        )
    }
    
//    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let  headerCell = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: SECTIONHEIGHT))
//        headerCell.backgroundColor = UIColor.whiteColor()
//        var frame = headerCell.frame
//        frame.origin.x = 16
//        let title = UILabel(frame: frame)
//        
//        if section == 0 { title.text = "Basketball" } else { title.text = "All Buildings"}
//        title.font = UIFont(name: "Avenir Book", size: 22)
//        title.textColor = UIColor.blackColor()
//        headerCell.addSubview(title)
//        
//        let line = UIView(frame: CGRect(x: 0, y: 0, width: headerCell.frame.width, height: 1))
//        line.backgroundColor = UIColor.lightGrayColor()
//        headerCell.addSubview(line)
//        
//        return headerCell
//    }
//    
//    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return SECTIONHEIGHT
//    }


}
