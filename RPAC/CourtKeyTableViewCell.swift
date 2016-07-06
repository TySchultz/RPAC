//
//  CourtKeyTableViewCell.swift
//  RPAC
//
//  Created by Ty Schultz on 6/27/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit

class CourtKeyTableViewCell: UITableViewCell {

    @IBOutlet weak var courtName: UILabel!
    @IBOutlet weak var courtDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
