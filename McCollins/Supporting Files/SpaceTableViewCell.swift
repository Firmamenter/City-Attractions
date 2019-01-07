//
//  SpaceTableViewCell.swift
//  VATCalculatorUAE
//
//  Created by mac on 11/25/17.
//  Copyright © 2017 M.Kamran. All rights reserved.
//

import UIKit
import Eureka

class SpaceTableViewCell: Cell<String>, CellType {
    
    /**
     Space View
     */
    @IBOutlet var spacerView: UIView!
    
    /**
     Flag to control the infinite space
     */
    var isInfinite: Bool = false {
        didSet {
            self.clipsToBounds = !isInfinite
        }
    }
    
    /**
     Height of the space row
     */
    var spaceHeight: CGFloat = 1.0
    
    // MARK: -View's Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
        selectionStyle = .none
    }
    
    /**
     Background color for space view
     */
    override var backgroundColor: UIColor? {
        didSet {
            spacerView.backgroundColor = backgroundColor
        }
    }
    
    /**
     Setting up cell with height of (spaceHeight + 1.0) pixels
     */
    override func setup() {
        super.setup()
        
        self.height = {[weak self] in
            guard let this = self else { return 2 }
            assert(this.spaceHeight >= 0.1, "Space height should be >= 0.1")
            return this.spaceHeight + 1.0
        }
    }
}
