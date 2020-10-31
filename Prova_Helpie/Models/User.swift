//
//  User.swift
//  Prova_Helpie
//
//  Created by Denis Fortuna on 27/10/20.
//  Copyright © 2020 Denis Fortuna. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class User: Object {
    dynamic var id = ""
    dynamic var name = ""
    dynamic var phoneNumber = ""
    dynamic var photoURL = ""
    dynamic var comments = ""
    dynamic var email = ""

    override class func primaryKey() -> String? {
        "id"
    }
    
    convenience init(name: String, phoneNumber: String, photoUrl: String, comments: String, email: String){
        self.init()
        self.id = UUID().uuidString
        self.name = name
        self.phoneNumber = phoneNumber
        self.photoURL = photoUrl
        self.comments = comments
        self.email = email
    }
}
