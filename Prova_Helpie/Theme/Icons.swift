//
//  Icons.swift
//  Prova_Helpie
//
//  Created by Denis Fortuna on 2/11/20.
//  Copyright © 2020 Denis Fortuna. All rights reserved.
//

import Foundation
import UIKit

enum Icons {
    case imageNotFound
    
    var image: UIImage {
        switch self {
        case .imageNotFound:
            return UIImage(systemName: "photo") ?? UIImage()
        }
    }
}
