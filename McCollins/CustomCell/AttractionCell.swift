//
//  AttractionCell.swift
//  McCollins
//
//  Created by Da Chen on 1/6/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

import UIKit

class AttractionCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var attractionTitle: UILabel!
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var timing: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var webBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
