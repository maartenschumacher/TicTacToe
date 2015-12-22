//
//  Game Logic.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 12/12/15.
//  Copyright © 2015 Maarten Schumacher. All rights reserved.
//

import Foundation

let computerField = Sign.Cross
let playerField = Sign.Circle

typealias Move = (Sign, Point)
typealias TicTacToeGrid = Grid<Field<Sign>>

func victory(grid: TicTacToeGrid) -> Bool {
    return grid
        .getAllLines()
        .contains { line in
            return line == [.Circle, .Circle, .Circle]
                || line == [.Cross, .Cross, .Cross]
    }
}

func computerMove(grid: TicTacToeGrid) -> Move {
    return grid
        .getAllLines()
        .filter { $0.contains(.Empty) }
        .map { GridLineAnalysis($0) }
}

struct GridLineAnalysis: Equatable {
    let empties: Int
    let circles: Int
    let crosses: Int
    
    init(empties: Int, circles: Int, crosses: Int) {
        self.empties = empties
        self.circles = circles
        self.crosses = crosses
    }
    
    init(line: [Sign]) {
        self.empties = line.containsCount(.Empty)
        self.circles = line.containsCount(.Circle)
        self.crosses = line.containsCount(.Cross)
    }
}

func ==(lhs: GridLineAnalysis, rhs: GridLineAnalysis) -> Bool {
    return lhs.empties == rhs.empties
        && lhs.circles == rhs.circles
        && lhs.crosses == rhs.crosses
}

enum Player {
    case Cross
    case Circle
    
    func returnIf<T>(cross cross: T, circle: T) -> T {
        switch self {
        case .Circle: return circle
        case .Cross: return cross
        }
    }
    
    var Sign: Sign {
        return returnIf(cross: .Cross, circle: .Circle)
    }
}

enum Priority: Int {
    case NoPriority = 0
    case Lowest
    case Low
    case Medium
    case High
    case Highest
    
    static func filterHighest(list: [Priority]) -> [Priority] {
        return filterHighest(list, start: .Highest)
    }
    
    private static func filterHighest(list: [Priority], start: Priority) -> [Priority] {
        if start == .NoPriority {
            return list
        }
        
        let result = list.filter { $0 == start }
        
        return result
            .isEmpty
            .returnIf(
                isTrue: filterHighest(list, start: Priority(rawValue: start.rawValue - 1)!),
                isFalse: result
            )
    }
}

