//
//  RealmCollectionTypes.swift
//  Prova_Helpie
//
//  Created by Denis Fortuna on 30/10/20.
//  Copyright © 2020 Denis Fortuna. All rights reserved.
//

import Foundation
import RealmSwift

enum RealmCollectionTypes {
    case user
    
    var path: Object.Type {
        switch self {
        case .user:
            return User.self
        }
    }
}
