//
//  SudokuCell.swift
//  Sudoku
//
//  Created by Venky Venkatakrishnan on 2/10/20.
//  Copyright © 2020 Venky UL. All rights reserved.
//

import Cocoa

protocol SudokuTextDelegate {
    
    func setValue(value: Int)
}

class SudokuCell: NSCollectionViewItem, SudokuTextDelegate {
    
    var cellRow: Int = 0
    var cellColumn: Int = 0
    
    var cellDelegate: SudokuCellDelegate?

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
        
        if let field = self.textField as? SudokuTextField {
            field.cellDelegate = self
        }
    
    }
    
    func setValue(value: Int) {
    
        self.cellDelegate?.setCellValue(row: cellRow, column: cellColumn, value: value)
      }
      

}

