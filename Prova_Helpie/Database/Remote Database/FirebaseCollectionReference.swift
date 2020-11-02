//
//  FirebaseCollectionReference.swift
//  Prova_Helpie
//
//  Created by Denis Fortuna on 1/11/20.
//  Copyright © 2020 Denis Fortuna. All rights reserved.
//

import Foundation

enum FIRCollectionReference {
    case userProfilePhoto(userID: String)
    
    var path: String {
        switch self {
            case .userProfilePhoto(let userID):
                return "Users/\(userID)"
        }
    }
}
