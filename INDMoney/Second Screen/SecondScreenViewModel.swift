//
//  SecondScreenViewModel.swift
//  INDMoney
//
//  Created by Astrotalk on 08/12/23.
//

import UIKit

enum CellType {     // Assigning Different Color for different Cell Types
    case police
    case ghost
    case normal
    
    var getColor: UIColor {
        switch self {
        case .police:
            UIColor.yellow
        case .ghost:
            UIColor.red
        case .normal:
            UIColor.gray
        }
    }
}

struct Point {
    let r: Int
    let c: Int
}

final class SecondScreenViewModel{
    let row: Int
    let col: Int
    
    private var policeLoc = Point(r: 0, c: 0)
    private var ghostLoc = Point(r: 0, c: 0)
    
    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
    
    private func isValid(_ p1: Point, _ p2: Point) -> Bool {
        return Set<Int>([p1.r, p2.r, p1.c, p2.c]).count == 4
    }
    
    private func generateValidTwoRandomPoints() -> (Point, Point) {
        var p1 = Point(r: 0, c: 0), p2 = Point(r: 0, c: 0)
        while(isValid(p1, p2) == false) {
            let r1 = Int.random(in: 0..<row)
            let c1 = Int.random(in: 0..<col)
            
            let r2 = Int.random(in: 0..<row)
            let c2 = Int.random(in: 0..<col)
            
            p1 = Point(r: r1, c: c1)
            p2 = Point(r: r2, c: c2)
        }
        
        return (p1, p2)
    }
    
    func generatePoliceAndGhostLoc() {
        let points = generateValidTwoRandomPoints()
        policeLoc = points.0
        ghostLoc = points.1
    }
    
    func getColor(_ r: Int, _ c: Int) -> UIColor {
        if(r == policeLoc.r && c == policeLoc.c) {
            return CellType.police.getColor
        }
        
        if(r == ghostLoc.r && c == ghostLoc.c) {
            return CellType.ghost.getColor
        }
        
        return CellType.normal.getColor
    }
    
    func updatePoliceLoc() {         // Update the location of police, after that reload CollectionView will be called from the View Controller
        var p = Point(r: 0, c: 0)
        
        while(isValid(p, ghostLoc) == false && isValid(policeLoc, p) == false) {
            let r = Int.random(in: 0..<row)
            let c = Int.random(in: 0..<col)
            
            p = Point(r: r, c: c)
        }
        
        policeLoc = p
    }
    
    func updateGhostLoc() {        // Update the location of Ghost, after that reload CollectionView will be called from the View Controller
        var p = Point(r: 0, c: 0)
        
        while(isValid(p, policeLoc) == false && isValid(ghostLoc, p) == false) {
            let r = Int.random(in: 0..<row)
            let c = Int.random(in: 0..<col)
            
            p = Point(r: r, c: c)
        }
        
        ghostLoc = p
    }
}
