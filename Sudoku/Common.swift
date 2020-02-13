//
//  Common.swift
//  Sudoku
//
//  Created by Venky Venkatakrishnan on 2/12/20.
//  Copyright © 2020 Venky UL. All rights reserved.
//

import Foundation

class SudokuCellFormatter: NumberFormatter {
    
    
    override func isPartialStringValid(_ partialString: String, newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>?, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        
        if (partialString.count == 1) {
            
            if partialString.isInt() {
            
               return true
            }
            else
            {
                return false
            }
        }
        else {
            return false
        }
    }
}

extension String {

    func isInt() -> Bool {

         if let intValue = Int(self) {

             if intValue >= 0 {
                 return true
             }
         }

         return false
     }
}
