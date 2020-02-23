//
//  ViewController.swift
//  Sudoku
//
//  Created by Venky Venkatakrishnan on 1/20/20.
//  Copyright © 2020 Venky UL. All rights reserved.
//

import Cocoa


protocol SudokuCellDelegate {
    
    func setCellValue(row: Int, column: Int, value:Int)
    
    // func handleTab(row: Int, column: Int)
}

class ViewController: NSViewController {


    @IBOutlet weak var collectionView: SudokuView!
    
    var sudoku: Sudoku = Sudoku()
    
    var sudokuElements = [[5,3,0,0,7,0,0,0,0],
                          [6,0,0,1,9,5,0,0,0],
                          [0,9,8,0,0,0,0,6,0],
                          [8,0,0,0,6,0,0,0,3],
                          [4,0,0,8,0,3,0,0,1],
                          [7,0,0,0,2,0,0,0,6],
                          [0,6,0,0,0,0,2,8,0],
                          [0,0,0,4,1,9,0,0,5],
                          [0,0,0,0,8,0,0,7,9]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        
        self.sudoku.setElements(elements: sudokuElements)
       
        // let firstCell = self.findUnprotectedCell(row: 0, column: 0, next: false)
        // firstCell.textField?.becomeFirstResponder()
        
        self.representedObject = self.sudoku
    }
    
    private func configureCollectionView() {
        
        let flowLayout = NSCollectionViewFlowLayout()
        
        let frameWidth = collectionView.frame.width
        
        let cellSize = frameWidth/9
        
        let cellHeight = cellSize
        
        flowLayout.itemSize = NSSize(width: cellSize, height: cellHeight)
        flowLayout.sectionInset = NSEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.wantsLayer = true
        
        collectionView.layer?.backgroundColor = NSColor.gray.cgColor
        
    }
    
    func findUnprotectedCell(row: Int, column: Int, next: Bool) -> SudokuCell {
    
           var cell: SudokuCell
           var cellColumn = column
           var cellRow = row
           
           let currentCell = self.collectionView.item(at: IndexPath(item: cellColumn, section: cellRow)) as! SudokuCell
           
           if currentCell.protected == false && !next {
               return currentCell
           }
           
           repeat
           {
              
               cellColumn = cellColumn + 1
                          
              if cellColumn > 8 {
               
                  cellColumn = 0
                  cellRow = cellRow + 1

              }
              
              if cellRow > 8 {
                  cellRow = 0
              }
               // print("cell(\(cellRow),\(cellColumn))")
               cell = self.collectionView.item(at: IndexPath(item: cellColumn, section: cellRow)) as! SudokuCell
            
            print(cell.protected)

           } while (cell.protected == true)
           
            print("current cell: (\(row),\(column)), next cell: (\(cellRow),\(cellColumn))")
           return cell
       }
       
}

extension ViewController: SudokuCellDelegate {

    
    func setCellValue(row: Int, column: Int, value: Int) {
        
        self.sudoku.elements[row][column] = value
        
        let changedCells = self.sudoku.checkSudokuAll()
        
        // print(changedCells)
        
        // var changedIndexPaths: [IndexPath] = []
        
        //print("setCellValue")
        //print(self.sudoku.elements)
        
        self.collectionView.reloadItems(at: changedCells)
        
    }
    
    /*func handleTab(row: Int, column: Int) {
        
        print("handleTab \(row) \(column)")
        
        let nextCell = findUnprotectedCell(row: row, column: column, next: true)
        nextCell.textField?.becomeFirstResponder()
    }
    */
    
    
}

extension ViewController: NSCollectionViewDataSource {
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "SudokuCell"), for: indexPath)
        
        guard let sudokuCell = item as? SudokuCell else { return item }
        
        let cellValue = self.sudoku.elements[indexPath.section][indexPath.item]
        
        sudokuCell.textField!.stringValue = cellValue == 0 ? "": cellValue.description
        
        let protected = self.sudoku.protectedElements[indexPath.section][indexPath.item]
        
        sudokuCell.protected = protected
        
        let rowError =  self.sudoku.rowError[indexPath.section][indexPath.item]
        
        let colError =  self.sudoku.colError[indexPath.section][indexPath.item]
        
        let squareError =
            self.sudoku.squareError[indexPath.section][indexPath.item]
            
        
        // print("indexPath \(indexPath.section), \(indexPath.item)")
        
        sudokuCell.error = rowError || colError || squareError
        
        sudokuCell.setPosition(row: indexPath.section, column: indexPath.item)
        
        
        sudokuCell.cellDelegate = self
   
        return sudokuCell
    }
}

