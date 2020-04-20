//
//  PlatformMethods.swift
//  Runner
//
//  Created by Tristan Bennett on 4/17/20.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

import Foundation

class PlatformMethods {
    let mainRealm = MainRealm()
    func listProduct(call: FlutterMethodCall, result: FlutterResult) {

        if let args = call.arguments as? [String: Any] {
          let id = args["id"] as! String
          let title = args["title"] as! String
          // realm.updateProductTitle(id, title);
          print("HEY, LISTEN!!!!!")
          result(String("Title is " + title + " and ID is " + id))
        } else {
            result(FlutterError(code: "BAD ARGS",
            message: "Unable to pass flutter arguments",
            details: nil))
          }
      }
    
//    func createCat(call: FlutterMethodCall, result: FlutterResult) {
//
//    }

      func listCat(call: FlutterMethodCall, result: FlutterResult) {
        if let args = call.arguments as? [String: Any] {
          let name = args["name"] as! String
          let age = args["age"] as! Int
          let owner = args["owner"] as! String
            let id = args["id"] as! Int

            mainRealm.writeToDB(id: id, name: name, age: age, owner: owner)
    //        let firstCat = mainRealm.readFromDB().first!;
            let catList: [String] = mainRealm.readFromDB()
            result(catList)
        }
      }
    
    func deleteCat(call: FlutterMethodCall, result: FlutterResult) {
        if let args = call.arguments as? [String: Int] {
            let id = args["id"]!
            result(mainRealm.deleteCat(id: id))
        }
    }
}
