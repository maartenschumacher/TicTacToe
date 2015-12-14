//
//  Grid+Lines.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 12/13/15.
//  Copyright © 2015 Maarten Schumacher. All rights reserved.
//

import Foundation

extension Grid {
    func getRow(row: Int) -> [Element] {
        return Array(0..<self.size.width).map { self.get(Point(x: $0, y: row)) }
    }
    
    func getColumn(column: Int) -> [Element] {
        return Array(0..<self.size.height).map { self.get(Point(x: column, y: $0)) }
    }
    
    func getRows() -> [[Element]] {
        return Array(0..<self.size.height).map { self.getRow($0) }
    }
    
    func getColumns() -> [[Element]] {
        return Array(0..<self.size.width).map { self.getColumn($0) }
    }
    
    func getDiagonal(from from: Point, direction: DiagonalDirection) -> [Element] {
        var xRange, yRange: [Int]
        
        switch direction {
        case .UpLeft:
            xRange = Array(0...from.x)
            yRange = Array(0...from.y)
        case .UpRight:
            xRange = Array(from.x..<self.size.width)
            yRange = Array(0...from.y)
        case .DownLeft:
            xRange = Array(0...from.x)
            yRange = Array(from.y..<self.size.height)
        case .DownRight:
            xRange = Array(from.x..<self.size.width)
            yRange = Array(from.y..<self.size.height)
        }
        
        return zip(one: Array(xRange), two: Array(yRange)).map { (x,y) in
            return self.get(Point(x: x, y: y))
        }
    }
    
    func getDiagonalsOfSquare() -> [[Element]] {
        return [
            self.getDiagonal(from: Point(x: 0, y: 0), direction: .DownRight),
            self.getDiagonal(from: Point(x: 0, y: self.size.height - 1), direction: .UpRight)
        ]
    }
}

enum DiagonalDirection {
    case UpLeft
    case UpRight
    case DownLeft
    case DownRight
}