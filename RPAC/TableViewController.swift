//
//  TableViewController.swift
//  RPAC
//
//  Created by Ty Schultz on 6/25/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit


class TableViewController: UITableViewController {

    var events : [Event]!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTitle: UILabel!
    var headerText = ""
    var showing = false
    var dismissing = false
    
    @IBOutlet weak var closeLineWidth: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        headerTitle.text = headerText
        
        closeLineWidth.constant = self.view.frame.width
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        showing = true
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if showing {
            return 1
        }else {
            return 0
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }

    @IBAction func closeController(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> TableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell

        let event = events[indexPath.row]
        cell.timeLabel.text = event.time
        cell.activityLabel.text = event.activity
        cell.locationLabel.text = event.location

        if event.activity.containsString("Basketball"){
            cell.stackColorBackground.backgroundColor = UIColor(red:0.10, green:0.65, blue:0.61, alpha:1.00)
            cell.activityLabel.textColor = UIColor.whiteColor()
            cell.timeLabel.textColor = UIColor.whiteColor()
            cell.locationLabel.textColor = UIColor.whiteColor()
        }else{
            cell.stackColorBackground.backgroundColor = UIColor.whiteColor()
            cell.activityLabel.textColor = UIColor.blackColor()
            cell.timeLabel.textColor = UIColor.blackColor()
            cell.locationLabel.textColor = UIColor.blackColor()

        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 100.0
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
    


}




