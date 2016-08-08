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
    
    var headerText = ""
    var showing = false
    var dismissing = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.navigationController?.navigationBarHidden = false

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        showing = true
        tableView.reloadData()
        self.navigationController?.navigationBarHidden = false
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
            self.navigationController?.navigationBarHidden = true
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


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> TableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewCell

        let event = events[indexPath.row]
        cell.timeLabel.text = event.time
        cell.activityLabel.text = event.activity
        cell.locationLabel.text = event.location
        
        

        if event.activity.containsString("Basketball"){
            cell.courtImage.image = cell.selectCourtImage(event.location)
            cell.spaceBetween.constant = 8

//            cell.activityLabel.textColor = UIColor(red:0.95, green:0.51, blue:0.23, alpha:1.00)
        }else{
            cell.courtImage.image = nil
            cell.spaceBetween.constant = -64
            cell.needsUpdateConstraints()
//            cell.activityLabel.textColor = UIColor.blackColor()

        }
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 100.0
    }
}




