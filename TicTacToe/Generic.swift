//
//  Generic.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 12/13/15.
//  Copyright © 2015 Maarten Schumacher. All rights reserved.
//

import Foundation

infix operator |>   { precedence 200 associativity left }
func |> <T,U>(lhs: T, rhs: T -> U) -> U {
    return rhs(lhs)
}

extension SequenceType where Generator.Element : Equatable {
    func containsCount(filterElement: Self.Generator.Element) -> Int {
        return self
            .filter { element in
                element == filterElement
            }
            .count
    }
}

extension Array {
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

struct Count<T: Equatable>: Equatable {
    let element: T
    let count: Int
    
    init(element: T, inArray: [T]) {
        self.element = element
        self.count = inArray
            .filter { $0 == element }
            .count
    }
    
    init(element: T, count: Int) {
        self.element = element
        self.count = count
    }
}

func ==<T>(lhs: Count<T>, rhs: Count<T>) -> Bool {
    return (lhs.element == rhs.element) && (lhs.count == rhs.count)
}

extension Bool {
    func returnIf<T>(isTrue isTrue: T, isFalse: T) -> T {
        if self == true {
            return isTrue
        } else {
            return isFalse
        }
    }
}
