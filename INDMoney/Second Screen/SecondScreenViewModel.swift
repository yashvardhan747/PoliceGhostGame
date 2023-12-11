//
//  SecondScreenViewModel.swift
//  INDMoney
//
//  Created by Astrotalk on 08/12/23.
//

import UIKit

enum CellType {
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

struct Point: Equatable {
    static func == (lhs: Point, rhs: Point) -> Bool {
        return lhs.r == rhs.r && lhs.c == rhs.c
    }
    
    let r: Int
    let c: Int
}

protocol SecondScreenViewModelDelegate: AnyObject {
    func reloadCollectionView()
}

final class SecondScreenViewModel{
    let row: Int
    let col: Int
    
    private var policeLoc = Point(r: 0, c: 0)
    private var ghostLoc = Point(r: 0, c: 0)
    
    weak var delegate: SecondScreenViewModelDelegate?
    
    init(row: Int, col: Int) {
        self.row = row
        self.col = col
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
}

//MARK: - Police and Ghost point generation

extension SecondScreenViewModel {
    private func isValid(_ p1: Point, _ p2: Point) -> Bool {
        return (p1.r != p2.r) && (p1.c != p2.c)
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
    
    func updatePoliceLoc() {
        var p = Point(r: 0, c: 0)
        
        while (p == policeLoc || p == ghostLoc) {
            let r = Int.random(in: 0..<row)
            let c = Int.random(in: 0..<col)
            
            p = Point(r: r, c: c)
        }
        
        policeLoc = p
        
        delegate?.reloadCollectionView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.updateGhostLoc()
        }
    }
    
    private func updateGhostLoc() {
        var p = Point(r: 0, c: 0)
        
        while p == ghostLoc || isValid(p, policeLoc) == false {
            let r = Int.random(in: 0..<row)
            let c = Int.random(in: 0..<col)
            
            p = Point(r: r, c: c)
        }
        
        ghostLoc = p
        delegate?.reloadCollectionView()
    }
}
