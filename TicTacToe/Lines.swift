//
//  Lines.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 12/15/15.
//  Copyright © 2015 Maarten Schumacher. All rights reserved.
//

import Foundation

struct Line<T: Equatable> {
    let fields: [Field<T>]
    var length: Int {
        return fields.count
    }
    
    var elements: [T] {
        return fields.map { $0.element}
    }
    
    func contains(element: T) -> Bool {
        return fields.contains { $0.element == element }
    }
}

struct Point {
    let x: Int
    let y: Int
}

struct Size {
    let width: Length
    let height: Length
}

struct Length {
    let length: Int
    
    var range: Range<Int> {
        return Range<Int>(start: 0, end: length)
    }
    
    func range(from from: Int) -> Range<Int> {
        return Range<Int>(start: from, end: length)
    }
    
    func range(to to: Int) -> Range<Int> {
        return Range<Int>(start: 0, end: to + 1)
    }
}

//protocol Line {
//    var length: Int { get }
//    var range: Range<Int> { get }
//    func points(otherCoordinate: Int) -> [Point]
//}
//
//extension Line {
//    var range: Range<Int> {
//        return Range<Int>(start: 0, end: length)
//    }
//    
//    func range(from from: Int) -> Range<Int> {
//        return Range<Int>(start: from, end: length)
//    }
//    
//    func range(to to: Int) -> Range<Int> {
//        return Range<Int>(start: 0, end: to + 1)
//    }
//}
//
//struct HorizontalLine: Line {
//    let length: Int
//    
//    func points(y: Int) -> [Point] {
//        return self.range.map { x in
//            return Point(x: x, y: y)
//        }
//    }
//}
//
//struct VerticalLine: Line {
//    let length: Int
//    
//    func points(x: Int) -> [Point] {
//        return self.range.map { y in
//            return Point(x: x, y: y)
//        }
//    }
//}
//
//struct DiagonalLine {
//    let horizontal: HorizontalLine
//    let vertical: VerticalLine
//    
//    var points: [Point] {
//        return zip(horizontal.range, vertical.range)
//            .map { (x,y) in
//                return Point(x: x, y: y)
//        }
//    }
//}