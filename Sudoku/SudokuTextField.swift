//
//  SudokuTextField.swift
//  Sudoku
//
//  Created by Venky Venkatakrishnan on 2/11/20.
//  Copyright © 2020 Venky UL. All rights reserved.
//

import Cocoa

class SudokuTextField: NSTextField {
    
    var cellDelegate: SudokuTextDelegate?

    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupTextField()
    }
      
    func setupTextField() {
        
        let formatter = SudokuCellFormatter()
        self.formatter = formatter
    }
    
    override func textDidBeginEditing(_ notification: Notification) {

        self.currentEditor()?.selectedRange = NSRange(location: 0, length: 0)
    }
    
    override func textDidEndEditing(_ notification: Notification) {
    
        self.cellDelegate?.setValue(value: Int(self.intValue))
    }
   
}
 
