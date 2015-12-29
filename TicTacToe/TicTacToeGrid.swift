//
//  TicTacToeGrid.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 12/29/15.
//  Copyright © 2015 Maarten Schumacher. All rights reserved.
//

import Foundation

struct TicTacToeGrid {
    let grid: Grid<Sign>
    
    static let initialState: TicTacToeGrid = TicTacToeGrid(
        grid:Grid(
            rows: 3,
            columns: 3,
            repeatedValue: .Empty
        )
    )
    
    func update(event: GridEvent) -> TicTacToeGrid {
        return TicTacToeGrid(
            grid: event.returnIf(
                playerMove: { point in self.grid.set(human.sign, at: point)},
                computerMove: self.grid.set(computer.sign, at: self.computerMove().point),
                reset: TicTacToeGrid.initialState.grid
            )
        )
    }
    
    func victory() -> Bool {
        return self.grid
            .getAllLines()
            .contains { line in
                return line.elements == [.Circle, .Circle, .Circle]
                    || line.elements == [.Cross, .Cross, .Cross]
        }
    }
    
    func computerMove() -> Field<Sign> {
        let lines = self.grid
            .getAllLines()
            .filter { $0.elements.contains(.Empty) }
        
        let priorities = lines
            .map { GridLineAnalysis(line: $0.elements) }
            .map { $0.priority }
        
        let highestPriorities = priorities
            |> Priority.filterHighest
        
        return zip(lines, priorities)
            .filter { (_, priority) in
                return highestPriorities.contains(priority)
            }
            .map { (line, priority) in line }
            .randomItem()
            .fields
            .filter { (field: Field<Sign>) in
                field.element == .Empty
            }
            .randomItem()
    }
}