//
//  GridButton.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 12/29/15.
//  Copyright © 2015 Maarten Schumacher. All rights reserved.
//

import Foundation
import UIKit

protocol GridButtonParent {
    var gridState: TicTacToeGrid { get }
}

class GridButton: Component {
    weak var button: UIButton!
    let point: Point
    
    var state: Sign = .Empty {
        willSet {
            button.setTitle(newValue.description, forState: .Normal)
        }
    }
    
    func applyState(state: GridButtonParent) {
        self.state = state.gridState.grid.get(at: self.point)
    }
    
    init(button: UIButton, point: Point) {
        self.button = button
        self.point = point
        
        button.setTitle(state.description, forState: .Normal)
    }
}