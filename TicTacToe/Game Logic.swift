//
//  Game Logic.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 12/12/15.
//  Copyright © 2015 Maarten Schumacher. All rights reserved.
//

import Foundation

let computerField = GridButtonState.Cross
let playerField = GridButtonState.Circle

struct TicTacToe {
    static func victory(grid: Grid<GridButtonState>) -> Bool {
        return [
            grid.getRows(),
            grid.getColumns(),
            grid.getDiagonalsOfSquare()
        ]
        .flatten()
        .contains { line in
            return line == [.Circle, .Circle, .Circle] || line == [.Cross, .Cross, .Cross]
        }
    }
    
    func analyzeLine(line: [GridButtonState]) -> GridLineAnalysis {
        return GridLineAnalysis(
            empty: line.containsCount(.Empty),
            circle: line.containsCount(.Circle),
            cross: line.containsCount(.Cross)
        )
    }
    
    
}

enum GridLineAnalysis {
    case Empty
    case Full
    case One(GridButtonState)
    case Two(GridButtonState)
    case Mixed
    
    static func analyze(line: [GridButtonState]) -> GridLineAnalysis {
        let empties = line.containsCount(.Empty)
        let circles = line.containsCount(.Circle)
        let crosses = line.containsCount(.Cross)
        
        if empties == 0 {
            return .Full
        } else if empties == 3 {
            return .Empty
        } else if empties == 1 {
            if circles == 2 {
                return .Two(.Circle)
            } else if crosses == 2 {
                return .Two(.Cross)
            } else if crosses == 1 && circles == 1 {
                return .Mixed
            }
        } else if empties == 2 {
            if circles == 1 {
                return .One(.Circle)
            } else if crosses == 1 {
                return .One(.Cross)
            }
        }
    }
    
    func priority(player: Player) -> Priority {
        switch self {
        case .Two(let field):
            return field.returnIf(
                empty: .NoPriority,
                cross: player.returnIf(cross: .Highest, circle: .High),
                circle: player.returnIf(cross: .High, circle: .Highest)
            )
            case 
        }
    }
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
    
    var gridButtonState: GridButtonState {
        return returnIf(cross: .Cross, circle: .Circle)
    }
}

enum Priority: Int {
    case Lowest = 0
    case Low
    case Medium
    case High
    case Highest
    case NoPriority
}

