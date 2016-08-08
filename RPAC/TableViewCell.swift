//
//  TableViewCell.swift
//  RPAC
//
//  Created by Ty Schultz on 6/25/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var stackColorBackground: TSView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var spaceBetween: NSLayoutConstraint!
    @IBOutlet weak var courtImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func selectCourtImage(courtName : String) -> UIImage {
        var fileName = "twdAll"
        
        switch courtName {
        //Upper Gym
        case "Upper Gym" :
            fileName = "upAll"
        case "UG #1-2" :
            fileName = "up12"
        case "UG #3-4" :
            fileName = "up34"
            
        //Bottom Gym
        case "TWD" :
            fileName = "twdAll"
        case "TWD #1-2" :
            fileName = "twd12"
        case "TWD $3-4" :
            fileName = "twd34"
            
        //Not likely but if a single court is available
        case _ where courtName.containsString("TWD"):
            switch courtName{
            case _ where courtName.containsString("1"):
                fileName = "twd1"
            case _ where courtName.containsString("2"):
                fileName = "twd2"
            case _ where courtName.containsString("3"):
                fileName = "twd3"
            case _ where courtName.containsString("4"):
                fileName = "twd4"
            default:
                fileName = "twdAll"
            }
            
        //Not likely but if a single court is available
        case _ where courtName.containsString("UG"):
            switch courtName{
            case _ where courtName.containsString("1"):
                fileName = "up1"
            case _ where courtName.containsString("2"):
                fileName = "up2"
            case _ where courtName.containsString("3"):
                fileName = "up3"
            case _ where courtName.containsString("4"):
                fileName = "up4"
            default:
                fileName = "upAll"
            }
        //Back Courts
        case "South Gym" :
            fileName = "south"
        case "North Gym" :
            fileName = "north"
        //Take Care of all other courts potentially
        case _ where courtName.containsString("Court"):
            fileName = "jo"
        default:
            fileName = "twdAll"
        }
        
        return UIImage(named: fileName)!
    }

}
