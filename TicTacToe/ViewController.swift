//
//  ViewController.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 12/12/15.
//  Copyright © 2015 Maarten Schumacher. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet weak var button0: UIButton!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    
    @IBOutlet weak var victoryLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    private var state = ScreenState.initialState {
        didSet {
            // self.children.apply(state)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gridComponent = GridComponent(children: [
            GridButton(button: button0, point: Point(x: 0, y: 0), outputObservable: gridComponent.observable),
            GridButton(button: button1, point: Point(x: 1, y: 0)),
            GridButton(button: button2, point: Point(x: 2, y: 0)),
            GridButton(button: button3, point: Point(x: 0, y: 1)),
            GridButton(button: button4, point: Point(x: 1, y: 1)),
            GridButton(button: button5, point: Point(x: 2, y: 1)),
            GridButton(button: button6, point: Point(x: 0, y: 2)),
            GridButton(button: button7, point: Point(x: 1, y: 2)),
            GridButton(button: button8, point: Point(x: 2, y: 2))
        ])
        
        let labelComponent = GameLabel(label: victoryLabel)
        
        let reset: Observable<GridEvent> = playAgainButton.rx_tap.map { _ in .Reset }
        
        [gridComponent.observable, reset]
            .toObservable()
            .merge()
            .scan(ScreenState.initialState) { state, event in
                return state.handle(event)
            }
            .subscribeNext { state in
                gridComponent.apply(state)
                labelComponent.apply(state)
            }
            .addDisposableTo(disposeBag)
                
    }
}

struct ScreenState: GridParent, GameLabelParent {
    let gridState: TicTacToeGrid
    let gameState: GameState
    
    static let initialState = ScreenState(
        gridState: TicTacToeGrid.initialState,
        gameState: .Playing
    )
    
    func set(gridState: TicTacToeGrid) -> ScreenState {
        return ScreenState(gridState: gridState, gameState: self.gameState)
    }
    
    func handle(event: GridEvent) -> ScreenState {
        return self.gameState.returnIf(
            playing: self.set(self.gridState.update(event)),
            won: { _ in self },
            tie: self
        )
    }
    
    func set(gameState: GameState) -> ScreenState {
        return ScreenState(gridState: self.gridState, gameState: gameState)
    }
}

enum ScreenEvent {
    case GridUpdate(TicTacToeGrid)
    case GameUpdate(GameState)
}

