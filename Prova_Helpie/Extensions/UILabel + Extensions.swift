//
//  UILabel + Extensions.swift
//  Prova_Helpie
//
//  Created by Denis Fortuna on 30/10/20.
//  Copyright © 2020 Denis Fortuna. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    func forTitle(_ title: String) {
        let titleLabel = UILabel()
        self.addSubview(titleLabel)
        titleLabel.text = title
        titleLabel.font = .preferredFont(forTextStyle: .callout)
        titleLabel.textColor = .systemBlue
        titleLabel.anchorEdges(top: nil,
                               left: self.leftAnchor,
                               right: nil,
                               bottom: self.topAnchor,
                               padding: .zero)
    }
}
