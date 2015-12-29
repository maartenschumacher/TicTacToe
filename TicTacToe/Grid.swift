//
//  Grid.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 12/12/15.
//  Copyright © 2015 Maarten Schumacher. All rights reserved.
//

import Foundation

struct Grid<Element: Equatable> {
    private let points: [[Element]]
    let size: Size
    
    init(rows: Int, columns: Int, repeatedValue: Element) {
        self.points = Array(
            count: rows,
            repeatedValue: Array(
                count: columns,
                repeatedValue: repeatedValue
            )
        )
        
        self.size = Size(
            width: Length(length: columns),
            height: Length(length: rows)
        )
    }
    
    init(points: [[Element]]) {
        self.points = points
        self.size = Size(
            width: Length(length: points[0].count),
            height: Length(length: points.count)
        )
    }
    
    func get(at at: Point) -> Element {
        return points[at.y][at.x]
    }
    
    func set(element: Element, at: Point) -> Grid {
        var mutablePoints = points
        mutablePoints[at.y][at.x] = element
        return Grid(points: mutablePoints)
    }
}

extension Grid {
    func getRow(row: Int) -> Line<Element> {
        return size.width.range
            .map { Point(x: $0, y: row) }
            |> line
    }
    
    func getColumn(column: Int) -> Line<Element> {
        return size.height.range
            .map { Point(x: column, y: $0) }
            |> line
    }
    
    func line(points: [Point]) -> Line<Element> {
        return points
            .map { Field(element: self.get(at: $0), point: $0) }
            |> Line<Element>.init
    }
    
    func getRows() -> [Line<Element>] {
        return size.height.range
            .map { self.getRow($0) }
    }
    
    func getColumns() -> [Line<Element>] {
        return size.width.range
            .map { self.getColumn($0) }
    }
    
    func getDiagonal(from from: Point, direction: DiagonalDirection) -> Line<Element> {
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
            .map { (point: Point) in
                return Field<Element>(element: self.get(at: point), point: point)
            }
            |> Line<Element>.init
    }
    
    func getDiagonalsOfSquare() -> [Line<Element>] {
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
    
    func getAllLines() -> [Line<Element>] {
        return [
            getRows(),
            getColumns(),
            getDiagonalsOfSquare()
        ].flatMap { $0 }
    }
}

