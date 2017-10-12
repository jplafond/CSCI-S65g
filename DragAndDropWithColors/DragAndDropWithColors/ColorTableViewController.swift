//
//  ColorTableViewController.swift
//  DragAndDropWithColors
//
//  Created by Jp LaFond on 10/11/17.
//  Copyright © 2017 Jp LaFond. All rights reserved.
//

/*
 As iOS 11's Drag & Drop functionality is only available for the iPad, a universal app still needs to handle the editing the older way.
 */

import MobileCoreServices
import UIKit

class ColorTableViewController: UITableViewController {
    /// A button that toggles between edit/save depending on the state
    var editSaveButton: UIBarButtonItem!
    /// A list of all of the colors that we'll present
    var colors = Color.allColors

    /// A stateful listener that will allow us to toggle between states
    var nowEditing = false {
        willSet {
            tableView.setEditing(newValue, animated: true)

            if newValue {
                editSaveButton.title = "Save"
            } else {
                editSaveButton.title = "Edit"
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Define the delegates for drag and drop
        tableView.dragDelegate = self
        tableView.dropDelegate = self

        // Define the toggling edit/save button for iPhones, as the Drag & Drop is in iOS 11
        if UIDevice.current.userInterfaceIdiom == .phone {
            editSaveButton = UIBarButtonItem(title: "Edit",
                                             style: .plain,
                                             target: self,
                                             action: #selector(editPressed(sender:)))
            self.navigationItem.rightBarButtonItem = editSaveButton
        }
    }

    // MARK: - Table view data source

    // With only one section, we don't need to define those

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath)

        // Configure the cell...
        let color = colors[indexPath.row]

        cell.textLabel?.text = color.description
        cell.backgroundColor = color.color.withAlphaComponent(0.7)

        return cell
    }

    // MARK: - Table View Delegate -- for movement
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Internal helper function
        func moveItem(at sourceIndex: Int, to destinationIndex: Int) {
            guard sourceIndex != destinationIndex else {
                return
            }

            let color = colors[sourceIndex]
            colors.remove(at: sourceIndex)
            colors.insert(color, at: destinationIndex)
        }

        // Actual moving the row
        moveItem(at: sourceIndexPath.row, to: destinationIndexPath.row)
    }

    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        // Normalize the input indexPath to keep it inside our information
        let proposedSection = 0
        let proposedRow: Int

        if proposedDestinationIndexPath.row < 0 {
            proposedRow = 0
        } else if proposedDestinationIndexPath.row >= colors.count {
            proposedRow = colors.count - 1
        } else {
            proposedRow = proposedDestinationIndexPath.row
        }

        return IndexPath(row: proposedRow, section: proposedSection)
    }

    // MARK: - UI Actions

    @IBAction func editPressed(sender: UIBarButtonItem) {
        // Toggle the state
        nowEditing = !nowEditing
    }
}

// MARK: - Drag Delegate
extension ColorTableViewController: UITableViewDragDelegate {
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        // Internal helper function
        func retrieveDragItems(forAlbumAt indexPath: IndexPath) -> [UIDragItem] {
            let color = colors[indexPath.row]
            let colorNameData = color.description.data(using: .utf8)
            let itemProvider = NSItemProvider()

            itemProvider.registerDataRepresentation(forTypeIdentifier: kUTTypePlainText as String,
                                                    visibility: .all)
            {   completion in

                completion(colorNameData, nil)
                return nil
            }

            return [UIDragItem(itemProvider: itemProvider)]
        }

        if tableView.isEditing {
            // User wants to reorder a row, don't return any drag items. The table view will allow a drag to begin for reordering only.
            return []
        }

        let dragItems = retrieveDragItems(forAlbumAt: indexPath)
        return dragItems
    }
}

// MARK: - Drop Delegate
extension ColorTableViewController: UITableViewDropDelegate {
    func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
        let destinationIndexPath: IndexPath

        if let indexPath = coordinator.destinationIndexPath {
            destinationIndexPath = indexPath
        } else {
            // Get last index path of table view.
            let section = tableView.numberOfSections - 1
            let row = tableView.numberOfRows(inSection: section)
            destinationIndexPath = IndexPath(row: row, section: section)
        }

        coordinator.session.loadObjects(ofClass: NSString.self)
        { items in

            // Consume drag items.
            let stringItems = items as! [String]

            var indexPaths = [IndexPath]()
            for (index, item) in stringItems.enumerated() {
                let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)

                print("\(#function)[\(#line)] item <\(item)>")
                let colorItem: Color
                if let color = Color(rawValue: item.lowercased()) {
                    colorItem = color
                } else {
                    colorItem = Color.gray
                }
                self.colors.insert(colorItem, at: indexPath.row)
                indexPaths.append(indexPath)
            }

            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }

    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        // The .move operation is available only for dragging within a single app.
        if tableView.hasActiveDrag {
            if session.items.count > 1 {
                return UITableViewDropProposal(operation: .cancel)
            } else {
                return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
            }
        } else {
            return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
        }
    }
}
