//
//  Fruit+JSON.swift
//  Lecture11_JSONParsing
//
//  Created by Jp LaFond on 7/18/17.
//  Copyright © 2017 Jp LaFond. All rights reserved.
//

import Foundation

extension Fruit {
    /*
     {
     "banana": {
         "color": "yellow",
         "howTasty": 7
         }
     }

    // The basic initializer cannot be created in this file.

     */
    /// Failable initializer (that needs an initializer with the default functionality
    init?(fruitDict: Dictionary<String, Any>) {
        guard fruitDict.keys.count == 1,
            let name = fruitDict.keys.first,
            let typeDict = fruitDict[name] as? Dictionary<String, Any>,
            let color = typeDict[Const.fruitJSON.colorKey] as? String,
            let howTasty = typeDict[Const.fruitJSON.tastyKey] as? Int
            else {
                print("Unexpected dictionary format: <\(fruitDict)>")
                return nil
        }

        // Calling the basic initialzier, I mentioned before.
        self.init(name: name, color: color, howTasty: howTasty)
    }

    /// Static function that will take an optional JSONObject that conforms to a known format: an dictionary, a dictionary that has an array of dictionaries with a known Types key.
    static func fruits(from json: Any?) -> [Fruit]? {
        guard let jsonDict = json as? Dictionary<String, Any>,
            let typesList = jsonDict[Const.fruitJSON.typesKey] as? Array<Any> else {
                print("JSON unexpected: \(String(describing: json))")
                return nil
        }
        var tmpFruits = [Fruit]()
        typesList.forEach {
            if let fruitDict = $0 as? Dictionary<String, Any>,
                let fruit = Fruit(fruitDict: fruitDict) {
                tmpFruits.append(fruit)
            }
            // Left as an exercise for students is handling a possible error rather than all failing
        }
        if tmpFruits.count == 0 {
            print("Fruits didn't convert")
            return nil
        }
        return tmpFruits
    }

    /// Static function to take a data object and try to turn it into a valid JSONObject.
    static func fruits(from data: Data) -> [Fruit]? {
        let jsonObject: Any
        do {
            jsonObject = try JSONSerialization.jsonObject(with: data,
                                                          options: .allowFragments)
        } catch {
            print("JSON Parsing failure: \(error)")
            return nil
        }
        // NOTE: The signatures of the two functions are *almost* identical.
        return fruits(from: jsonObject)
    }

    /// Static function to take a json file name and turn it into a Data object, if it can be opened
    static func fruits(from file: String = Const.file.fruit.name) -> [Fruit]? {
        guard let jsonPath = Bundle.main.path(forResource: file,
                                              ofType: Const.file.fruit.ext)
            else {
                print("File not present: \(file)")
                return nil
        }
        let jsonURL = URL(fileURLWithPath: jsonPath)
        // Error handling
        let jsonData: Data
        do {
            jsonData = try Data(contentsOf: jsonURL)
        } catch {
            print("JSON Data failure: \(error)")
            return nil
        }
        return fruits(from: jsonData)
    }
}

extension Fruit {
    /// Convert a JSONObject into a JSONString
    var jsonString: String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject,
                                                  options: .prettyPrinted)
            let jsonString = String(data: jsonData,
                                    encoding: .utf8)
            if jsonString == nil {
                print("Unable to convert to String: <\(jsonObject)>")
            }
            print("jsonString <\(jsonString ?? "*nil*")>")
            return jsonString
        } catch {
            print("Unable to convert <\(jsonObject)>")
        }
        return nil
    }

    /*
     {
     "banana": {
         "color": "yellow",
         "howTasty": 7
         }
     }
     */
    /// Convert a fruit into a Dictionary for conversion into a JSONString
    var jsonObject: Any {
        let tmpJsonDict: Dictionary<String, Any> =
            [name: [Const.fruitJSON.colorKey: color,
                    Const.fruitJSON.tastyKey: howTasty]]

        return tmpJsonDict
    }


}
