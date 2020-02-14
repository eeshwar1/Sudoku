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
    var elements:[[Int]] = []
    
    var protectedElements:[[Bool]] = []
    
    required override init() {
        super.init()
        self.elements = Array(repeating: Array(repeating: 0, count: dimension), count: dimension)
        
        self.protectedElements = Array(repeating: Array(repeating: false, count: dimension), count: dimension)
    }
    
    required init(elements: [[Int]]) {
        
        super.init()
        setElements(elements: elements)
    }
    
    func setElements(elements: [[Int]]) {
        
        self.elements = elements
        
        
        for (row,elementRow) in self.elements.enumerated() {
            
            for (column, element) in elementRow.enumerated() {
                
                let protected =  element == 0 ? false : true
                
                self.protectedElements[row][column] = protected
                

            }
        }
    }
    

    
}
