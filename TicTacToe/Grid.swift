//
//  Grid.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 12/12/15.
//  Copyright © 2015 Maarten Schumacher. All rights reserved.
//

import Foundation

struct Grid<Element> {
    private let points: [[Element]]
    let size: Size
    
    init(with rows: Int, columns: Int, repeatedValue: Element) {
        self.points = Array(
            count: rows,
            repeatedValue: Array(
                count: columns,
                repeatedValue: repeatedValue
            )
        )
        
        self.size = Size(width: columns, height: rows)
    }
    
    init(points: [[Element]]) {
        self.points = points
        self.size = Size(width: points[0].count, height: points.count)
    }
    
    func get(at: Point) -> Element {
        return points[at.y][at.x]
    }
    
    func set(element: Element, at: Point) -> Grid {
        var mutablePoints = points
        mutablePoints[at.y][at.x] = element
        return Grid(points: mutablePoints)
    }
}

struct Point {
    let x: Int
    let y: Int
}

struct Size {
    let width: Int
    let height: Int
}
