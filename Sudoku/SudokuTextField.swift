//
//  SudokuTextField.swift
//  Sudoku
//
//  Created by Venky Venkatakrishnan on 2/11/20.
//  Copyright © 2020 Venky UL. All rights reserved.
//

import Cocoa

class SudokuTextField: NSTextField {
    
    var textDelegate: SudokuTextDelegate?
    
    var active: Bool = false
    
    var protected: Bool = true {
        
        didSet {
            
            self.isEditable = !protected
            self.isSelectable = !protected
            self.refusesFirstResponder = protected
            
            self.backgroundColor = self.protected ? Colors.protectedCellColor : Colors.inactiveCellColor
            
            self.textColor = self.protected ? Colors.protectedTextColor : Colors.textColor
        }
    }

    var error: Bool = true {
        
        didSet {
            
            if self.stringValue == "" {
            
                self.layer?.borderColor = (self.active ? Colors.activeBorderColor :  Colors.inactiveBorderColor).cgColor

            }
            else {
                  
                self.layer?.borderColor = (error ? Colors.errorBorderColor : (self.active ? Colors.activeBorderColor : Colors.inactiveBorderColor)).cgColor
                self.backgroundColor = error ? Colors.errorCellColor : (self.active ? Colors.activeCellColor : Colors.inactiveCellColor)
            }
          
        }
    }
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
        
        self.drawsBackground = true
        self.maximumNumberOfLines = 1
        self.isBezeled = true
        
        self.layer?.borderWidth = 2.0
    
        
    }
    
    override func becomeFirstResponder() -> Bool {
        
        if self.protected {
            
            return false
        }
        self.backgroundColor = self.error ? Colors.errorCellColor : Colors.activeCellColor
    
        self.active = true
        return super.becomeFirstResponder()
    }
    
    override func textDidBeginEditing(_ notification: Notification) {

        // print("textDidBeginEditing")
        self.currentEditor()?.selectedRange = NSRange(location: 0, length: 0)
       
    }
    
    override func textDidEndEditing(_ notification: Notification) {
    
        // print("textDidEndEditing")
        
        self.textDelegate?.setValue(value: Int(self.intValue))
        
        self.backgroundColor = self.error ? Colors.errorCellColor : Colors.inactiveCellColor
        self.active = false
    }
    
    /*
    override func keyUp(with event: NSEvent) {
        
        if let char = event.characters
        {
            if char == "\t" {
                print("Tab pressed")
                self.textDelegate?.handleTab()
            }
            
        }
        

        
    } */
    
    
   
}
 
