//
//  ImgViewExtension.swift
//  McCollins
//
//  Created by Da Chen on 1/7/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

import UIKit
import Foundation

extension UIImageView {
    func makeCircle() {
        self.layer.cornerRadius = self.frame.size.height/2
        self.layer.masksToBounds = true
        self.superview!.layer.cornerRadius = self.frame.size.height/2
        self.superview!.layer.borderWidth = 1
        self.superview!.layer.borderColor = UIColor.white.cgColor
        self.superview!.layer.masksToBounds = true
    }
}
