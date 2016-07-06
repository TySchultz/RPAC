//
//  CourtKeyTableViewController.swift
//  RPAC
//
//  Created by Ty Schultz on 6/27/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit

class CourtKeyTableViewController: UITableViewController {

    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTitle: UILabel!
    var headerText = ""
    var showing = false
    var dismissing = false
    
    
    let COURTNAMES = ["TWD #1-2",
                      "TWD #3-4",
                      "UG #1-2",
                      "UG #3-4",
                      "South Gym",
                      "North Gym"]
    
    let COURTDESCRIPTIONS = ["Bottom floor of the rpac. Near the bottom of the main staircase.",
                      "Bottom floor of the rpac. The courts near the main weight room.",
                      "2nd Floor of the rpac. The courts nearest the small cardio section",
                      "2nd Floor of the rpac. The courts nearest to the scarlet skyway",
                      "Bottom floor of the rpac. Past the equipment rentals and near the back.",
                      "Bottom floor of the rpac. Past the equipment rentals. Even further past the south gym. Way back in the corner"]
    
    @IBOutlet weak var closeLineWidth: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        closeLineWidth.constant = self.view.frame.width

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
        return COURTNAMES.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> CourtKeyTableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CourtKey", forIndexPath: indexPath) as! CourtKeyTableViewCell
        
        cell.courtName.text = COURTNAMES[indexPath.row]
        cell.courtDescription.text = COURTDESCRIPTIONS[indexPath.row]
        
        return cell
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        print(offset)
        var frame = headerView.frame
        frame.origin.y = offset
        headerView.frame = frame
        
        if offset < -120 && !dismissing{
            dismissing = true
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        if offset < 0 {
            closeLineWidth.constant =  self.view.frame.width + ((offset/120) * self.view.frame.width)
        }else{
            closeLineWidth.constant = self.view.frame.width
        }
    }
    
    @IBAction func closeController(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
