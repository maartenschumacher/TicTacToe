//
//  GridComponent.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 12/30/15.
//  Copyright © 2015 Maarten Schumacher. All rights reserved.
//

import Foundation
import RxSwift

protocol GridParent {
    var gridState: TicTacToeGrid { get }
}

struct GridComponent: Component {
    func inputTransform(input: Observable<Point>, output: Observable<GridParent>) -> Observable<GridEvent> {
        let playerMove = input
            .withLatestFrom(output) { point, grid in
                (point, grid)
            }
            .filter { (point: Point, grid: GridParent) in
                grid.gridState.grid.get(at: point) == .Empty
            }
            .map { point, grid
                in GridEvent.PlayerMove(point)
            }
        
        let computerMove = playerMove.flatMap { _ in
            timer(1.0, MainScheduler.sharedInstance)
                .map { _ in GridEvent.ComputerMove }
            }
            .publish()
        
        computerMove.connect()
        
        return [playerMove, computerMove]
            .toObservable()
            .merge()
    }
    
    func outputTransform(output: Observable<GridParent>) -> Observable<TicTacToeGrid> {
        return output.map { $0.gridState }
    }
}

enum GridEvent {
    case PlayerMove(Point)
    case ComputerMove
    case Reset
    
    func returnIf<T>(playerMove playerMove: Point -> T, computerMove: T, reset: T) -> T {
        switch self {
        case .PlayerMove(let point): return playerMove(point)
        case .ComputerMove: return computerMove
        case .Reset: return reset
        }
    }
}