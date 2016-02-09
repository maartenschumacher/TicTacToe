//
//  Generic.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 12/13/15.
//  Copyright © 2015 Maarten Schumacher. All rights reserved.
//

import Foundation

func repeatT<T>(value: T, times: Int) -> [T] {
    return Array(count: times, repeatedValue: value)
}

func flatRepeat<T>(values: [T], times: Int) -> [T] {
    return Array(Array(count: times, repeatedValue: values).flatten())
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
        return self ? isTrue : isFalse
    }
}



