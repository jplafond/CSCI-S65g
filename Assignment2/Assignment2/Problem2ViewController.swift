//
//  Problem2ViewController.swift
//  Assignment2
//
//  Created by Keshav Aggarwal on 29/06/16.
//  Copyright © 2016 Harvard Summer School. All rights reserved.
//

import UIKit

class Problem2ViewController: UIViewController {

    @IBOutlet weak var displayText: UITextView!
    
    var before: [[Bool]] = []
    var after: [[Bool]] = []
    let size = 3
    let shifts = [-1, 0, 1]
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.navigationItem.title = "Problem 2";
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func runClicked(sender: AnyObject) {
        
        displayText.text = "Yeah!! We were clicked 2!!"
        print("Yes..the button was clicked 2!!")
        
        // Initialising the 'before' and 'after'array
        for row in 0..<size {
            before.append([])
            after.append([])
            for _ in 0..<size {
                if arc4random_uniform(3) == 1 {
                    // set current cell to alive
                    before[row].append(true)
                } else {
                    // set current cell to dead
                    before[row].append(false)
                }
                after[row].append(false)
            }
        }
        
        let aliveBefore = countLivingCells(before)
        displayText.text = displayText.text + "\nThe number of cells alive before is \(aliveBefore)."
        
        for row in 0..<size {
            for column in 0..<size {
                let numberOfNeighbours = countNeighbours(before, row: row, column: column)
                switch numberOfNeighbours {
                case 2:
                    after[row][column] = before[row][column]
                case 3:
                    after[row][column] = true
                default:
                    break
                }
            }
        }
        
        let aliveAfter = countLivingCells(after)
        displayText.text = displayText.text + "\nThe number of cells alive after is \(aliveAfter)."
    }
    
    func countLivingCells(cellGrid: [[Bool]]) -> Int {
        var cellsAlive = 0
        for row in 0..<size {
            for column in 0..<size {
                if(cellGrid[row][column] == true) {
                    cellsAlive += 1
                }
            }
        }
        return cellsAlive
    }
    
    func countNeighbours(cellGrid: [[Bool]], row: Int, column: Int) -> Int {
        var numberOfNeigbours = 0
        for yShift in shifts {
            for xShift in shifts {
                if !(xShift == 0 && yShift == 0) {
                    
                    var neighbouringColumn = (column + xShift) % size
                    if neighbouringColumn == -1 {
                        neighbouringColumn += size
                    }
                    
                    var neighbouringRow = (row + yShift) % size
                    if neighbouringRow == -1 {
                        neighbouringRow += size
                    }
                    
                    if cellGrid[neighbouringRow][neighbouringColumn] {
                        numberOfNeigbours += 1
                    }
                }
            }
        }
        return numberOfNeigbours
    }
    
}
