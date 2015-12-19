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
    
    let disposeBag = DisposeBag()
    
    let initialState: Grid<GridButtonState> = Grid(
        with: 3,
        columns: 3,
        repeatedValue: .Empty
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttons = [
            ButtonComponent(button: button0, point: Point(x: 0, y: 0)),
            ButtonComponent(button: button1, point: Point(x: 1, y: 0)),
            ButtonComponent(button: button2, point: Point(x: 2, y: 0)),
            ButtonComponent(button: button3, point: Point(x: 0, y: 1)),
            ButtonComponent(button: button4, point: Point(x: 1, y: 1)),
            ButtonComponent(button: button5, point: Point(x: 2, y: 1)),
            ButtonComponent(button: button6, point: Point(x: 0, y: 2)),
            ButtonComponent(button: button7, point: Point(x: 1, y: 2)),
            ButtonComponent(button: button8, point: Point(x: 2, y: 2))
        ]
        
        let commands: [Observable<Point>] = buttons
            .map { gridButton in
                return gridButton.button.rx_tap.map { _ in gridButton.point }
            }
        
        commands
            .toObservable()
            .merge()
            .scan(initialState) { grid, point in
                return grid.set(GridButtonState.Circle, at: point)
            }
            .subscribeNext { grid in
                for gridButton in buttons {
                    gridButton.state = grid.get(at: gridButton.point)
                }
                
                if TicTacToe.victory(grid) {
                    self.victoryLabel.text = "Someone wins!"
                }
            }
            .addDisposableTo(disposeBag)
    }

}

class ButtonComponent {
    weak var button: UIButton!
    let point: Point
    
    var state: GridButtonState = .Empty {
        willSet {
            button.setTitle(newValue.description, forState: .Normal)
        }
    }
    
    init(button: UIButton, point: Point) {
        self.button = button
        self.point = point
        
        button.setTitle(state.description, forState: .Normal)
    }
}

