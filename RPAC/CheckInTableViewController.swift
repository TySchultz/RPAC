//
//  CheckInTableViewController.swift
//  RPAC
//
//  Created by Ty Schultz on 6/27/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit

class CheckInTableViewController: UITableViewController {

    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerTitle: UILabel!
    var headerText = ""
    var showing = false
    var dismissing = false
    
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
        return 6
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
    
    

}
