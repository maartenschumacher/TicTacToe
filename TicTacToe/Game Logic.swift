//
//  Game Logic.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 12/12/15.
//  Copyright © 2015 Maarten Schumacher. All rights reserved.
//

import Foundation

let computer = Player.Cross
let human = Player.Circle


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
    
    var priority: Priority {
        return ruleMatching(analysis: self)?
            .priority(computer) ?? .NoPriority
    }
}

func ==(lhs: GridLineAnalysis, rhs: GridLineAnalysis) -> Bool {
    return lhs.empties == rhs.empties
        && lhs.circles == rhs.circles
        && lhs.crosses == rhs.crosses
}

enum Player {
    case Circle
    case Cross
    
    func returnIf<T>(circle circle: T, cross: T) -> T {
        switch self {
        case .Circle: return circle
        case .Cross: return cross
        }
    }
    
    var sign: Sign {
        return returnIf(circle: .Circle, cross: .Cross)
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

