//
//  Generic.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 12/13/15.
//  Copyright © 2015 Maarten Schumacher. All rights reserved.
//

import Foundation

extension SequenceType where Generator.Element : Equatable {
    func containsCount(filterElement: Self.Generator.Element) -> Int {
        return self
            .filter { element in
                element == filterElement
            }
            .count
    }
}

struct Count<Element> {
    let element: Element
    let count: Int
}