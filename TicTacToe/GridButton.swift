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

class GridButton: Component {
    weak var button: UIButton!
    let point: Point
    
    let disposeBag = DisposeBag()
    
    var observable: Observable<Point> {
        return button.rx_tap.map { _ in self.point }
    }
    
    func apply(state: TicTacToeGrid) {
        let sign = state.grid.get(at: self.point)
        button.setTitle(sign.description, forState: .Normal)
    }
    
    init(button: UIButton, point: Point) {
        self.button = button
        self.point = point
        //button.setTitle(self.state.description, forState: .Normal)
    }
}