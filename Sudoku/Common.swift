//
//  Common.swift
//  Sudoku
//
//  Created by Venky Venkatakrishnan on 2/12/20.
//  Copyright © 2020 Venky UL. All rights reserved.
//

import Foundation
import Cocoa

struct Colors {
    
    static let protectedCellColor = NSColor.darkGray
    static let activeCellColor = NSColor.yellow.blended(withFraction: 0.5, of: NSColor.white)
    static let inactiveCellColor = NSColor.white
    static let errorCellColor = NSColor.red.blended(withFraction: 0.5, of: NSColor.white)
    static let inactiveBorderColor = NSColor.gray
    static let activeBorderColor = NSColor.green
    static let errorBorderColor = NSColor.red
    
    static let textColor = NSColor.black
    static let protectedTextColor = NSColor.white
    
    
    
}

class SudokuCellFormatter: NumberFormatter {
    
    
    override func isPartialStringValid(_ partialString: String, newEditingString newString: AutoreleasingUnsafeMutablePointer<NSString?>?, errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        
        guard partialString.count > 0 else { return true }
        
        if (partialString.count == 1) {
            
            if partialString.isInt() {
                
                if let intValue = Int(partialString)
                {
                    if intValue > 0 {
                        return true
                    }
                    else
                    {
                        return false
                    }
                }
                else
                {
                      return false
                }
              
                    
             
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
