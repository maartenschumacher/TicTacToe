//
//  Directions.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 12/15/15.
//  Copyright © 2015 Maarten Schumacher. All rights reserved.
//

import Foundation

typealias DiagonalDirection = (
    vertical: VerticalDirection,
    horizontal: HorizontalDirection
)

enum HorizontalDirection {
    case Left
    case Right
    
    func returnIf<T>(left left: T, right: T) -> T {
        switch self {
        case .Left: return left
        case .Right: return right
        }
    }
}

enum VerticalDirection {
    case Up
    case Down
    
    func returnIf<T>(up up: T, down: T) -> T {
        switch self {
        case .Up: return up
        case .Down: return down
        }
    }
}