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
    
    // Size of the matrix
    let size = 10
    
    // Shifts to find row and column of neighbouring cells
    let shifts = [-1, 0, 1]
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        // Setting navigation title
        self.navigationItem.title = "Problem 2";
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func runClicked(sender: AnyObject) {
        
        // Defining the 'before' cell grid
        var before: [[Bool]] = []
        
        // Initialising the 'before' grid/matrix
        for row in 0..<size {
            before.append([])
            for _ in 0..<size {
                if arc4random_uniform(3) == 1 {
                    // Set current cell to alive
                    before[row].append(true)
                } else {
                    // Set current cell to dead
                    before[row].append(false)
                }
            }
        }
        
        // Displaying number of alive cells in 'before' grid
        let aliveBefore = countLivingCells(before)
        displayText.text = "The number of cells alive before is \(aliveBefore)."
        
        let after = step(before)
        
        // Displaying number of alive cells in 'after' grid
        let aliveAfter = countLivingCells(after)
        displayText.text = displayText.text + "\nThe number of cells alive after is \(aliveAfter)."
    }
    
    // Counts number of cells alive in a grid
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
    
}
