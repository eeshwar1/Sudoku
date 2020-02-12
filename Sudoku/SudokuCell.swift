//
//  SudokuCell.swift
//  Sudoku
//
//  Created by Venky Venkatakrishnan on 2/10/20.
//  Copyright © 2020 Venky UL. All rights reserved.
//

import Cocoa

class SudokuCell: NSCollectionViewItem, NSTextFieldDelegate{

    let formatter = Formatter()
    
    var protected: Bool = false {
        didSet {
            
            self.textField?.isEditable = !protected
            self.textField?.isSelectable = !protected
            
            self.textField?.backgroundColor = protected ? NSColor.darkGray : NSColor.white
            
            self.textField?.textColor = protected ? NSColor.white : NSColor.black
        }
    }
    
    var correct: Bool = false {
        
        didSet {
            
            self.textField?.layer?.borderColor = correct ? NSColor.gray.cgColor: NSColor.red.cgColor
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.textField?.wantsLayer = true
        self.textField?.layer?.borderWidth = 1.0
        
        self.textField?.delegate = self
      
    
    }
    
    func controlTextDidChange(_ obj: Notification) {
        
        guard let field = obj.object as? NSTextField else { return }
        
        print(field.stringValue)
       
    }
    
}
