//
//  RealmService.swift
//  Prova_Helpie
//
//  Created by Denis Fortuna on 30/10/20.
//  Copyright © 2020 Denis Fortuna. All rights reserved.
//

import Foundation
import RealmSwift

struct RealmService {
    
    private init() {}
    static let shared = RealmService()
    let realm = try! Realm()
    
    func addObject<T: Object>(_ object: T) {
        //Add an unmanaged object to this Realm
        do {
            try realm.write {
                realm.add(object, update: .all)
            }
        } catch {
            print("create object error catched")
        }
    }
    
    func fecthAllObjects(fromCollection collType: RealmCollectionTypes) ->  [Object] {
        Array(realm.objects(collType.path))
    }
    
    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("create object error catched")
        }
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String: Any?]) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            print("create object error catched")
        }
    }
}
