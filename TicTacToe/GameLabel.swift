//
//  GameLabel.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 12/29/15.
//  Copyright © 2015 Maarten Schumacher. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

protocol GameLabelParent {
    var gameState: GameState { get }
}

class GameLabel: Component {
    weak var label: UILabel!
    var state: GameState {
        didSet {
            self.label.text = self.state.description
        }
    }
    
    init(label: UILabel) {
        self.label = label
        self.state = GameState.initialState
    }
    
    func apply(state: GameLabelParent) {
        self.state = state.gameState
    }
}

enum GameEvent: Event {
    case Victory(Player)
    case Tie
    case Reset
    
    func returnIf<T>(victory victory: Player -> T, tie: T, reset: T) -> T {
        switch self {
        case .Victory(let player): return victory(player)
        case .Tie: return tie
        case .Reset: return reset
        }
    }
}

enum GameState {
    case Playing
    case Won(Player)
    case Tie
    
    static let initialState: GameState = .Playing
    
    var description: String {
        return returnIf(
            playing: "",
            won: { player in
                player.returnIf(
                    circle: "You win!",
                    cross: "Computer wins."
                )
            },
            tie: "It's a tie!"
        )
    }
    
    func returnIf<T>(playing playing: T, won: Player -> T, tie: T) -> T {
        switch self {
        case .Playing: return playing
        case .Won(let player): return won(player)
        case .Tie: return tie
        }
    }
}