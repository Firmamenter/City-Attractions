//
//  SpaceCellRow.swift
//  VATCalculatorUAE
//
//  Created by mac on 11/25/17.
//  Copyright © 2017 M.Kamran. All rights reserved.
//

import Foundation
import Eureka

final class SpaceCellRow: Row<SpaceTableViewCell>, RowType {
    
    /**
     Initializes the row
     - parameter tag: tag for the row
     - returns: Void
     */
    required init(tag: String?) {
        super.init(tag: tag)
        
        cellProvider = CellProvider<SpaceTableViewCell>(nibName: "SpaceTableViewCell")
    }
}
