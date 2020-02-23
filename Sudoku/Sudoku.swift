//
//  Sudoku.swift
//  Sudoku
//
//  Created by Venky Venkatakrishnan on 2/11/20.
//  Copyright © 2020 Venky UL. All rights reserved.
//

import Foundation

class Sudoku : NSObject {
    
    var dimension: Int = 9
    
    var elements:[[Int]] = [] {
        didSet {
            // self.checkSudokuAll()
        }
    }
    
    var protectedElements:[[Bool]] = []
    
    var rowError:[[Bool]] = []
    var colError:[[Bool]] = []
    var squareError:[[Bool]] = []
    
    required override init() {
        
        super.init()
        
        self.elements = Array(repeating: Array(repeating: 0, count: dimension), count: dimension)
        
        self.protectedElements = Array(repeating: Array(repeating: false, count: dimension), count: dimension)
        
        self.rowError =  Array(repeating: Array(repeating: false, count: dimension), count: dimension)
        self.colError =  Array(repeating: Array(repeating: false, count: dimension), count: dimension)
        self.squareError =  Array(repeating: Array(repeating: false, count: dimension), count: dimension)
    }
    
    required init(elements: [[Int]]) {
        
        super.init()
        setElements(elements: elements)
    }
    
    func setElements(elements: [[Int]]) {
        
        self.elements = elements
        
        
        for (row,elementRow) in self.elements.enumerated() {
            
            for (column, element) in elementRow.enumerated() {
                
                let protected = element == 0 ? false : true
                
                self.protectedElements[row][column] = protected
                

            }
        }
    }
    

    func checkSudokuAll() -> Set<IndexPath>
    {
        // print("Checking...")
        
        let oldRowError = self.rowError
        let oldColError = self.colError
        let oldSquareError =  self.squareError
        
        for rowNum in 0...dimension - 1 {
            self.checkRow(rowNum: rowNum)
        }
        
        for colNum in 0...dimension - 1 {
            self.checkColumn(colNum: colNum)
        }
        
        for startRow in stride(from: 0, through: 6, by: 3) {
            //for startCol in stride(from: 0, through: 6, by: 3) {
                
                self.checkSquares(startRow: startRow, startCol: startRow)
           // }
        }
        
        var updatedErrorCells = Set<IndexPath> ()
        
        for rowNum in 0...dimension - 1 {
            for colNum in 0...dimension - 1 {
                
                let oldCellError = oldRowError[rowNum][colNum] ||
                                   oldColError[rowNum][colNum] ||
                                   oldSquareError[rowNum][colNum]
                    
                
                let newCellError = self.rowError[rowNum][colNum] ||
                                   self.colError[rowNum][colNum] ||
                                   self.squareError[rowNum][colNum]
                
                if oldCellError != newCellError {
                    updatedErrorCells.insert(IndexPath(item: colNum, section: rowNum))
                }
            }
            
            
        }
        
        return updatedErrorCells
        // print(self.elementError)
    }
    
    func checkSudoku(row: Int, column: Int) {
        
        // print("Checking...")
   
        self.checkRow(rowNum: row)
        
        self.checkColumn(colNum: column)
        
    }
    
    func checkRow(rowNum: Int)
    {
        // print("Checking row \(rowNum)...")
        
        self.rowError[rowNum] = Array(repeating: false, count: dimension)
        
        for col1 in 0...dimension - 1
        {
            for col2 in 0...dimension - 1
            {
                if col1 != col2 {
                    if self.elements[rowNum][col1] == self.elements[rowNum][col2] {
                    
                        if self.elements[rowNum][col2] != 0 &&
                        self.protectedElements[rowNum][col2] == false {
                            self.rowError[rowNum][col2] = true
                    
                        }
                   }
                }
            }
        }
        
        
    }
    
    func checkColumn(colNum: Int)
     {
         //print("Checking column \(colNum)...")
        
        // reset error flags
        for row in 0...dimension - 1 {
            self.colError[row][colNum] = false
        }
        
        // check for errors
        for row1 in 0...dimension - 1
        {
            for row2 in 0...dimension - 1
            {
                if row1 != row2 {
                    if self.elements[row1][colNum] == self.elements[row2][colNum] {
                    
                        if self.elements[row2][colNum] != 0 &&
                        self.protectedElements[row2][colNum] == false {
                            self.colError[row2][colNum] = true
                    
                        }
                   }
                }
            }
        }
     }
    
    func checkSquares(startRow: Int, startCol: Int)
     {
      
        let endRow = startRow + 2
        let endCol = startCol + 2
        
        var squareCells = Set<IndexPath>()
        
        for rowNum in startRow...endRow
        {
            for colNum in startCol...endCol
            {
                squareCells.insert(IndexPath(item: colNum, section: rowNum))
                self.squareError[rowNum][colNum] = false
            }
        }
        
        // print(squareCells)
        for cell1 in squareCells
        {
            for cell2 in squareCells {
                
                if cell1 != cell2 {
                    
                    if self.elements[cell1.section][cell1.item] ==
                        self.elements[cell2.section][cell2.item] {
                        
                        if self.protectedElements[cell2.section][cell2.item] == false &&
                            self.elements[cell2.section][cell2.item] != 0
                        {
                            self.squareError[cell2.section][cell2.item] = true
                        }
                    }
                }
            }
        }
        
     }
}
