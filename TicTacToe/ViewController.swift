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
        
        let gridButtons = zip(
                flatRepeat([0,1,2], times: 3),
                [0,1,2].flatMap { repeatT($0, times: 3) }
            )
            .map { x, y in
                Point(x: x, y: y)
            }
            .map { point in
                GridButton(point: point)
            }
        
        let buttons = [
                button0, button1, button2,
                button3, button4, button5,
                button6, button7, button8
            ]
            .map { outlet in
                ButtonComponent(outlet: outlet)
            }
        
        let labelComponent = GameLabel(label: victoryLabel)
        
        let reset: Observable<GridEvent> = playAgainButton.rx_tap.map { _ in .Reset }
        
        let componentFactory = ComponentFactory(
            initialState: ScreenState.initialState,
            flow: GridComponent() |> gridButtons |> buttons,
            transform: { (input: Observable<GridEvent>) in
                input
                    .scanWithStart(ScreenState.initialState) { state, event in
                        state.handle(event)
                    }
            }
        )
        
//        [gridComponent.observable, reset]
//            .toObservable()
//            .merge()
//            .scan(ScreenState.initialState) { state, event in
//                return state.handle(event)
//            }
//            .subscribeNext { state in
//                gridComponent.apply(state)
//                labelComponent.apply(state)
//            }
//            .addDisposableTo(disposeBag)
//                
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

