//
//  Game Logic.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 12/12/15.
//  Copyright © 2015 Maarten Schumacher. All rights reserved.
//

import Foundation

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
}