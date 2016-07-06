//
//  CollectionViewCell.swift
//  RPAC
//
//  Created by Ty Schultz on 6/26/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit

class CollectionViewCell: UITableViewCell {

    @IBOutlet weak var scrollView: UIScrollView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let box = UIView(frame: CGRect(x: 0, y: 0, width: 128, height: 128))
        box.backgroundColor = UIColor(red:0.15, green:0.16, blue:0.13, alpha:1.00)
        box.layer.cornerRadius = 8.0
        scrollView.addSubview(box)
        
        scrollView.contentSize = CGSize(width: self.frame.size.width*2, height: 128)
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 128, height: 128))
        button.setTitle("Check In?", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(16.0, weight: UIFontWeightRegular)
        box.addSubview(button)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
