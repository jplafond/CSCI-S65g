//
//  Constants.swift
//  Lecture11_JSONParsing
//
//  Created by Jp LaFond on 7/18/17.
//  Copyright © 2017 Jp LaFond. All rights reserved.
//

struct Const {
    struct table {
        static let cellIdentifier = "jsonCell"
    }
    struct file {
        static let weather = (name: "stateWeatherData",
                              ext: "json")
        static let fruit = (name: "fruit",
                            ext: "json",
                            url: "https://www.dropbox.com/s/ngvp307xmlsjwdj/fruit.json?dl=0")
        // dl=1 will work, dl=0 will not because it returns a web page, not a json file.
    }
    struct fruitJSON {
        static let fruitsKey = "fruits"
        static let typesKey = "types"
        static let colorKey = "color"
        static let tastyKey = "howTasty"
    }
}
