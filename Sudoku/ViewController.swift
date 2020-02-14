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
}
class ViewController: NSViewController {


    @IBOutlet weak var collectionView: NSCollectionView!
    
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
       
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    private func configureCollectionView() {
        
        let flowLayout = NSCollectionViewFlowLayout()
        
        let frameWidth = collectionView.frame.width
        
        let cellSize = frameWidth/9
        
        flowLayout.itemSize = NSSize(width: cellSize, height: cellSize)
        flowLayout.sectionInset = NSEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        flowLayout.minimumInteritemSpacing = 0.0
        flowLayout.minimumLineSpacing = 0.0
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.wantsLayer = true
        
        collectionView.layer?.backgroundColor = NSColor.gray.cgColor
        
    }
}

extension ViewController: SudokuCellDelegate {
    
    func setCellValue(row: Int, column: Int, value: Int) {
        self.sudoku.elements[row][column] = value
        
        print(self.sudoku.elements)
    }
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
        
        sudokuCell.cellRow = indexPath.section
        sudokuCell.cellColumn = indexPath.item
        
        sudokuCell.cellDelegate = self
        
        if sudokuCell.protected == false {
            
            sudokuCell.correct = true
      
        }
        return sudokuCell
    }
}

