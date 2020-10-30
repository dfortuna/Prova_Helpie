//
//  FakeUsers.swift
//  Prova_Helpie
//
//  Created by Denis Fortuna on 28/10/20.
//  Copyright © 2020 Denis Fortuna. All rights reserved.
//

import Foundation

struct FakeUsers {
    static func getUsers() -> [User] {
        
        let names = ["Liam",
        "Noah",
        "Oliver",
        "William",
        "Elijah",
        "James",
        "Benjamin",
        "Lucas",
        "Mason",
        "Ethan",
        "Alexander",
        "Henry",
        "Jacob",
        "Michael",
        "Daniel",
        "Logan",
        "Jackson",
        "Sebastian",
        "Jack",
        "Aiden"]
        
        var users = [User]()
        for name in names {
            
            let prefixNumber = Int.random(in: 1000..<10000)
            let sufixNumber = Int.random(in: 1000..<10000)
            let number = "\(prefixNumber)-\(sufixNumber)"
            
            let url = "www.\(name).com.br"
            let email = "\(name)@gmail.com"
            
            let comments = name + name + name + name
            
            let user = User(name: name,
                            phoneNumber: number,
                            photoURL: url,
                            comments: comments,
                            email: email)
            users.append(user)
        }
        return users
    }
}
