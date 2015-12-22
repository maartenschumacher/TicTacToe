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
        return size.width.range
            .map { Point(x: $0, y: row) }
            .map { self.get(at: $0) }
    }
    
    func getColumn(column: Int) -> [Element] {
        return size.height.range
            .map { Point(x: column, y: $0) }
            .map { self.get(at: $0) }
    }
    
    func getRows() -> [[Element]] {
        return size.height.range
            .map { self.getRow($0) }
    }
    
    func getColumns() -> [[Element]] {
        return size.width.range
            .map { self.getColumn($0) }
    }
    
    func getDiagonal(from from: Point, direction: DiagonalDirection) -> [Element] {
        let xRange = direction.horizontal.returnIf(
            left: size.width.range(to: from.x),
            right: size.width.range(from: from.x)
        )
        
        let yRange = direction.vertical.returnIf(
            up: size.height.range(to: from.y),
            down: size.height.range(from: from.y)
        )
        
        return zip(xRange, yRange)
            .map { (x,y) in
                return Point(x: x, y: y)
            }
            .map { point in
                return self.get(at: point)
            }
    }
    
    func getDiagonalsOfSquare() -> [[Element]] {
        return [
            self.getDiagonal(
                from: Point(x: 0, y: 0),
                direction: (.Down, .Right)
            ),
            self.getDiagonal(
                from: Point(x: 0, y: self.size.height.length - 1),
                direction: (.Up, .Right)
            )
        ]
    }
    
    func getAllLines() -> [[Element]] {
        return [
                getRows(),
                getColumns(),
                getDiagonalsOfSquare()
            ]
            .flatMap { $0 }
    }
}



