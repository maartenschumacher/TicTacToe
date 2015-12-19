//
//  Lines.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 12/15/15.
//  Copyright © 2015 Maarten Schumacher. All rights reserved.
//

import Foundation

struct Point {
    let x: Int
    let y: Int
}

struct Size {
    let width: Line
    let height: Line
}

protocol Line {
    var length: Int { get }
    var range: Range<Int> { get }
    func points(otherCoordinate: Int) -> [Point]
}

extension Line {
    var range: Range<Int> {
        return Range<Int>(start: 0, end: length)
    }
}

struct HorizontalLine: Line {
    let length: Int
    
    func points(y: Int) -> [Point] {
        return self.range.map { x in
            return Point(x: x, y: y)
        }
    }
}

struct VerticalLine: Line {
    let length: Int
    
    func points(x: Int) -> [Point] {
        return self.range.map { y in
            return Point(x: x, y: y)
        }
    }
}

struct DiagonalLine {
    let horizontal: HorizontalLine
    let vertical: VerticalLine
    
    var points: [Point] {
        return zip(horizontal.range, vertical.range)
            .map { (x,y) in
                return Point(x: x, y: y)
        }
    }
}