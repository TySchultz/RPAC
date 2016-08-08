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
    
    
    let COURTNAMES = ["TWD",
                      "UG",
                      "South Gym",
                      "North Gym",
                      "Court #1-2"]
    
    let COURTDESCRIPTIONS = ["Bottom floor of the RPAC. Near the main staircase and cardio canyon.",
                      "The courts on the upper level of the RPAC.",
                      "Bottom floor of the rpac. Go past the equipment rentals and locker rooms.",
                      "Bottom floor of the rpac. Go past the equipment rentals and locker rooms. Even farther back then the south courts",
                      "This could either be JO North or JO South"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.navigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = true
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
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> TableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell
        
        cell.activityLabel.text = COURTNAMES[indexPath.row]
        cell.locationLabel.text = COURTDESCRIPTIONS[indexPath.row]
        cell.courtImage.image = getImage(indexPath.row)
        return cell
    }
    
    
    func getImage(index : Int) -> UIImage {
        
        switch index {
        case 0:
            return UIImage(named: "twdAll")!
        case 1:
            return UIImage(named: "upAll")!
        case 2:
            return UIImage(named: "south")!
        case 3:
            return UIImage(named: "north")!
        case 4:
            return UIImage(named: "jo")!
        default:
            return UIImage(named: "twdAll")!
        }
        
        return UIImage(named: "twdAll")!

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
