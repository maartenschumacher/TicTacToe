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

struct GridButton: Component {
    let point: Point
    
    func inputTransform(input: Observable<()>, output: Observable<TicTacToeGrid>) -> Observable<Point> {
        return input.map { _ in self.point }
    }
    
    func outputTransform(output: Observable<TicTacToeGrid>) -> Observable<String> {
        return output
            .map { state in
                state.grid.get(at: self.point)
            }
            .map { $0.description }
    }
}