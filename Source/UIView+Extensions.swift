//
//  UIView+Extensions.swift
//  PropellerKit
//
//  Created by RGfox on 2/7/17.
//  Copyright © 2017 Propeller. All rights reserved.
//

import UIKit

extension UIView {
    
    /// build constraints for fitting into specified superview
    public func boundInside(superview: UIView, constraints: ((NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint) -> Void)? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false   
        let left   = leftAnchor.constraint(equalTo:   superview.leftAnchor)
        let top    = topAnchor.constraint(equalTo:    superview.topAnchor)
        let right  = rightAnchor.constraint(equalTo:  superview.rightAnchor)
        let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        left.isActive   = true
        top.isActive    = true
        right.isActive  = true
        bottom.isActive = true
        constraints?(left, top, right, bottom)
    }
}
