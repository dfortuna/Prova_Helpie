//
//  UIView + Extensions.swift
//  Prova_Helpie
//
//  Created by Denis Fortuna on 27/10/20.
//  Copyright © 2020 Denis Fortuna. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func anchorEdges(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?,
                     right: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?,
                     padding: UIEdgeInsets) {
        //Add constraints from this view's edges to another and adds padding.
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: padding.left).isActive = true
        }
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: padding.right).isActive = true
        }
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }
    }

    func anchorSizes(sizeWidth: CGFloat?, sizeHeight: CGFloat?) {
        //Add constraints for view's height and width.
        self.translatesAutoresizingMaskIntoConstraints = false
        if let sizeWidth = sizeWidth {
            self.widthAnchor.constraint(equalToConstant: sizeWidth).isActive = true
        }
        if let sizeHeight = sizeHeight {
            self.heightAnchor.constraint(equalToConstant: sizeHeight).isActive = true
        }
    }
    
    func anchorCenters(centerX: NSLayoutXAxisAnchor?, centerY: NSLayoutYAxisAnchor?) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let centerX = centerX {
            self.centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        if let centerY = centerY {
            self.centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
}

