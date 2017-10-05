//
//  Fruit.swift
//  Lecture11_JSONParsing
//
//  Created by Jp LaFond on 7/18/17.
//  Copyright © 2017 Jp LaFond. All rights reserved.
//

import Foundation

// MARK: - Fruit
/// A fruit model based upon the fruit definition in the JSON
/*
 {
     "banana": {
         "color": "yellow",
         "howTasty": 7
         }
      }
 */
struct Fruit {
    let name: String
    let color: String
    let howTasty: Int

    /// Basic functionality won't need this, because it's the default functionality
    init(name: String, color: String, howTasty: Int) {
        self.name = name
        self.color = color
        self.howTasty = howTasty
    }
}

extension Fruit: CustomStringConvertible {
    var description: String {
        return "\(name):\(color):[\(howTasty)]"
    }
}
