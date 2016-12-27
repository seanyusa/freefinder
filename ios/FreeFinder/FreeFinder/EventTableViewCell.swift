//
//  EventTableViewCell.swift
//  FreeFinder
//
//  Created by Sean on 12/26/16.
//  Copyright © 2016 Sean Wang. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventSecondaryLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!

    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var shirtImageView: UIImageView!
    @IBOutlet weak var resumeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
