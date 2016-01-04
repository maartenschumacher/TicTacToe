//
//  Components.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 1/3/16.
//  Copyright © 2016 Maarten Schumacher. All rights reserved.
//

import Foundation

protocol Component {
    typealias ComponentParent
    func apply(state: ComponentParent)
}

protocol Event {}