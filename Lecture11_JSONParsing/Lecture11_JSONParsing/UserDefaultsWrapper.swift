//
//  UserDefaultsWrapper.swift
//  Lecture11_JSONParsing
//
//  Created by Jp LaFond on 7/21/17.
//  Copyright © 2017 Jp LaFond. All rights reserved.
//

import Foundation

class UDWrapper {
    /// A static method to retrieve a string with a known key from UserDefaults
    class func getLastSavedFruit(key: String = Const.UserDefaults.lastSavedFruitKey) -> String? {
        return UserDefaults.standard.string(forKey:key)
    }

    /// A static method to save a string value for a known key in UserDefaults
    class func setLastSavedFruit(key: String = Const.UserDefaults.lastSavedFruitKey, value: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
}

extension Const {
    struct UserDefaults {
        /// The known key
        static let lastSavedFruitKey = "lastSavedFruit"
    }
}
