//
//  Engine.swift
//  Assignment2
//
//  Created by Keshav Aggarwal on 02/07/16.
//  Copyright © 2016 Harvard Summer School. All rights reserved.
//

import Foundation

// Size of the matrix
let size = 10

// Shifts to find row and column of neighbouring cells
let shifts = [-1, 0, 1]

func step(before: [[Bool]]) -> [[Bool]] {
    
    // Defining the 'after' cell grid
    var after: [[Bool]] = []
    
    // Initialising the 'after' grid/matrix
    for row in 0..<size {
        after.append([])
        for _ in 0..<size {
            after[row].append(false)
        }
    }
    
    //
    for row in 0..<size {
        for column in 0..<size {
            let numberOfNeighbours = countNeighboursAlive(before, row: row, column: column)
            switch numberOfNeighbours {
            // Cell state unchanged
            case 2:
                after[row][column] = before[row][column]
            // Cell reproduction
            case 3:
                after[row][column] = true
            // Cell death: overcrowding/undercrowding
            default:
                break
            }
        }
    }
    return after
}

// Counts number of alive neighbours for a given cell
func countNeighboursAlive(cellGrid: [[Bool]], row: Int, column: Int) -> Int {
    var numberOfNeigbours = 0
    
    for yShift in shifts {
        for xShift in shifts {
            // Ignoring the cell itself
            if !(xShift == 0 && yShift == 0) {
                
                // Handling neighbours for cells along the edges
                var neighbouringColumn = (column + xShift) % size
                if neighbouringColumn == -1 {
                    neighbouringColumn += size
                }
                
                var neighbouringRow = (row + yShift) % size
                if neighbouringRow == -1 {
                    neighbouringRow += size
                }
                
                // Add count if neighbouring cell is alive
                if cellGrid[neighbouringRow][neighbouringColumn] {
                    numberOfNeigbours += 1
                }
            }
        }
    }
    return numberOfNeigbours
}

