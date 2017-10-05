//
//  JSONTableViewController.swift
//  Lecture11_JSONParsing
//
//  Created by Jp LaFond on 7/18/17.
//  Copyright © 2017 Jp LaFond. All rights reserved.
//

import UIKit

class JSONTableViewController: UITableViewController {

    // Use a local JSON file
    var fruits = Fruit.fruits()?
        .sorted() { if $0.howTasty == $1.howTasty {
                return $0.name < $1.name
        }
            return $0.howTasty > $1.howTasty
    }

//    var fruits: [Fruit]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Make a network call to pull down the json file from the web using a known URL
//        if let fruitUrl = URL(string: Const.file.fruit.url) {
//            let dataTask = URLSession.shared.dataTask(with: fruitUrl)
//            {   (data, response, error) in
//
//                if let error = error {
//                    print(error)
//                } else {
//                    print("Response: \(String(describing: response))")
//                    if let data = data {
//                        self.fruits = Fruit.fruits(from: data)
//                        self.fruits = self.fruits?
//                            .sorted() { $0.howTasty > $1.howTasty &&
//                                $0.name < $1.name &&
//                                $0.color < $1.color}
//
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData()
//                        }
//
//                    } else {
//                        print("The call didn't work")
//                    }
//                }
//            }
//            dataTask.resume()
//        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presentLastSavedFruit()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let fruits = fruits else {
            return 1
        }
        return fruits.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.table.cellIdentifier,
                                                 for: indexPath)
        // A default value that may or may not be replaced -- this could also be done in the Storyboard using a default value defined there.
        cell.textLabel?.text = "*No fruit present*"

        if let fruits = fruits {
            cell.textLabel?.text = fruits[indexPath.row].name.capitalized
            cell.detailTextLabel?.text = fruits[indexPath.row].description
        }

        return cell
    }

    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let fruits = fruits else {
            return
        }
        let fruit = fruits[indexPath.row]
        saveFruit(fruit)
    }
}

extension JSONTableViewController {
    /// Helper function to grab a saved fruit string and convert it into a fruit, if possible, and present it
    func presentLastSavedFruit() {
        guard let jsonFruitString = UDWrapper.getLastSavedFruit(),
            let jsonData = jsonFruitString.data(using: .utf8),
            let jsonObject = try? JSONSerialization.jsonObject(with: jsonData,
                                                               options: .allowFragments),
            let fruitDict = jsonObject as? Dictionary<String, Any>,
            let fruit = Fruit(fruitDict: fruitDict) else {
                print("Unable to retrieve lastSaved <\(String(describing: UDWrapper.getLastSavedFruit()))>")
                return
        }
        print("Retrieved: \(fruit)")
        let alertView = UIAlertController(title: "Last Saved Fruit", message: "Your fruit was: \(fruit)",
            preferredStyle: .alert)
        let dismissButton = UIAlertAction(title: "Dismiss",
                                          style: .default,
                                          handler: nil)
        alertView.addAction(dismissButton)
        present(alertView, animated: true, completion: nil)
    }

    /// Save the fruit given as a fruit string
    func saveFruit(_ fruit: Fruit) {
        if let jsonString = fruit.jsonString {
            UDWrapper.setLastSavedFruit(value: jsonString)
            print("Saving: \(fruit)")
        } else {
            print("Unable to save lastSaved")
        }
    }
}
