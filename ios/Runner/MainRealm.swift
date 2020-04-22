//
//  MainRealm.swift
//  Runner
//
//  Created by Tristan Bennett on 4/17/20.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

import Foundation
import RealmSwift

class MainRealm {
    let realm = try! Realm()

    func writeToDB(id: Int, name: String, age: Int, owner: String) {
        let newCat = Cat()
        newCat.id = id
        newCat.name = name
        newCat.age = age
        newCat.owner = owner

        try! realm.write {
            realm.add(newCat)
        }
    }
    func readFromDB() -> [String] {
        let cats = realm.objects(Cat.self)
        var catStringsList = [String]()
        for cat in cats {
            catStringsList.append("ID: \(cat.id), Name: \(cat.name), Age: \(String(cat.age)), Owner: \(cat.owner)")
        }
        return catStringsList
    }
    
    func deleteCat(id: Int) -> String {
        let cat = realm.objects(Cat.self).filter("id == \(id)").first!
        try! realm.write {
            realm.delete(cat)
        }
        return "Successfully deleted cat where ID == \(id)"
    }
}
