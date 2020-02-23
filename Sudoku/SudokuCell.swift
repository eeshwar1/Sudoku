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
    
    func handleTab()
}

class SudokuCell: NSCollectionViewItem, SudokuTextDelegate, NSTextFieldDelegate {
    
    var row: Int = 0
    var column: Int = 0
    
    var cellDelegate: SudokuCellDelegate?
    
    // @IBOutlet weak var labelPosition: NSTextField!

    var protected: Bool = false {
        
        didSet {
            
            if let textField = self.textField as? SudokuTextField {
                
                textField.protected = self.protected
            }
        
        }
    }
    
    var error: Bool = true {
        
        didSet {
            
            if let textField = self.textField as? SudokuTextField {
                 
                if textField.protected == false {
                    textField.error = self.error
                }
             }
           
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.textField?.wantsLayer = true
        self.textField?.layer?.borderWidth = 2.0
        
        if let field = self.textField as? SudokuTextField {
            field.textDelegate = self
        }
    
        self.textField!.delegate = self
        
        // self.labelPosition.stringValue = "(\(cellRow), \(cellColumn))"
        
    }
    
    func setPosition(row: Int, column: Int) {
        
        self.row = row
        self.column = column
        
        // self.labelPosition.stringValue = "(\(cellRow), \(cellColumn))"
    }
    
    func setValue(value: Int) {
    
        self.cellDelegate?.setCellValue(row: row, column: column, value: value)
        
      }
    
    func handleTab() {
        
        print("\(row),\(column)")
        // self.cellDelegate?.handleTab(row: self.row, column: self.column)
        
    }
 

}

