//
//  UIImageView+Extensions.swift
//  Prova_Helpie
//
//  Created by Denis Fortuna on 2/11/20.
//  Copyright © 2020 Denis Fortuna. All rights reserved.
//

import Foundation
import UIKit
import SkeletonView

extension UIImageView {
    
    func load(urlString: String, radious: Float) {
        self.isSkeletonable = true
        self.skeletonCornerRadius = radious
        self.showAnimatedGradientSkeleton()
        self.image = Icons.imageNotFound.image
        self.contentMode = .center
        self.tintColor = .lightGray
        if let urlImage = URL(string: urlString) {
            DispatchQueue.global().async { [weak self] in
                if let dataImage = try? Data(contentsOf: urlImage) {
                    if let image = UIImage(data: dataImage) {
                        DispatchQueue.main.async {
                            self?.image = image
                            self?.contentMode = .scaleAspectFill
                            self?.layer.borderWidth = 0
                            self?.hideSkeleton()
                        }
                    } else {
                        DispatchQueue.main.async {
                            self?.hideSkeleton()
                            self?.layer.borderWidth = 1
                        }
                        
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.hideSkeleton()
                        self?.layer.borderWidth = 1
                    }
                }
            }
        } else {
            self.hideSkeleton()
            self.layer.borderWidth = 1
        }
    }
}
