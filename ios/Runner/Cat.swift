//
//  Cat.swift
//  Runner
//
//  Created by Tristan Bennett on 4/17/20.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

import Foundation
import RealmSwift

class Cat: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var age = 0
    @objc dynamic var owner = ""
}
