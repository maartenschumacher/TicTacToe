//
//  GridButton.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 12/29/15.
//  Copyright © 2015 Maarten Schumacher. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol GridButtonParent {
    var gridState: TicTacToeGrid { get }
}

class GridButton: Component {
    weak var button: UIButton!
    let point: Point
    let observable: Observable<GridEvent>
    
    let disposeBag = DisposeBag()
    
    var state: Sign = .Empty {
        willSet {
            button.setTitle(newValue.description, forState: .Normal)
        }
    }
    
    func apply(state: GridButtonParent) {
        self.state = state.gridState.grid.get(at: self.point)
    }
    
    init(button: UIButton, point: Point) {
        self.button = button
        self.point = point
        self.observable = button.rx_tap.map { _ in .PlayerMove(point) }
        
        button.setTitle(state.description, forState: .Normal)
    }
}