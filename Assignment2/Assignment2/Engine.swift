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

func step2(before: [[Bool]]) -> [[Bool]] {
    
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
            let cellNeighbours = neighbours((row, column))
            let numberOfNeighboursAlive = countNeighboursAlive(before, cellNeighbours: cellNeighbours)
            switch numberOfNeighboursAlive {
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
func countNeighboursAlive(cellGrid: [[Bool]], cellNeighbours: [(Int, Int)]) -> Int {
    var numberOfNeigbours = 0
    for cell in cellNeighbours {
        let row = cell.0
        let column = cell.1
        // Add count if neighbouring cell is alive
        if cellGrid[row][column] {
            numberOfNeigbours += 1
        }
    }
    return numberOfNeigbours
}

// Return array of neighbours to a given cell
func neighbours(cellCoordinates: (Int, Int)) -> [(Int, Int)]{
    var neighbouringCells: [(Int, Int)] = []
    for yShift in shifts {
        for xShift in shifts {
            // Ignoring the cell itself
            if !(xShift == 0 && yShift == 0) {
                
                // Handling wrapping for cells along the edges
                var neighbouringColumn = (cellCoordinates.1 + xShift) % size
                if neighbouringColumn == -1 {
                    neighbouringColumn += size
                }
                
                // Handling wrapping for cells along the edges
                var neighbouringRow = (cellCoordinates.0 + yShift) % size
                if neighbouringRow == -1 {
                    neighbouringRow += size
                }
                
                // Appending neighbouring cells to array
                neighbouringCells.append((neighbouringRow, neighbouringColumn))
            }
        }
    }
    return neighbouringCells
}


/*
-------------------------------PROBLEM 3-------------------------------
 
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
 
                // Handling wrapping for cells along the edges
                var neighbouringColumn = (column + xShift) % size
                if neighbouringColumn == -1 {
                    neighbouringColumn += size
                }
 
                // Handling wrapping for cells along the edges
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
*/
