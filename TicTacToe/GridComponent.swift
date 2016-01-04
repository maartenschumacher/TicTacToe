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

class GridComponent: Component {
    let children: [GridButton]
    
    var observable: Observable<GridEvent> {
        let playerMove: Observable<GridEvent> = self.children
            .map { $0.observable }
            .toObservable()
            .merge()
            .filter { point in
                self.state.grid.get(at: point) == .Empty
            }
            .map { point in .PlayerMove(point) }
        
        let computerMove = playerMove.flatMap { _ in
                timer(1.0, MainScheduler.sharedInstance)
                    .map { _ in GridEvent.ComputerMove }
            }
            .publish()
        
        computerMove.connect()
        
        return [playerMove, computerMove]
            .toObservable()
            .merge()
            .debug("gridstrema")
    }
    
    private var state = TicTacToeGrid.initialState {
        didSet {
            self.children.forEach { $0.apply(self.state) }
        }
    }
    
    init(children: [GridButton]) {
        self.children = children
    }
    
    func apply(state: GridParent) {
        self.state = state.gridState
    }
}

enum GridEvent: Event {
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