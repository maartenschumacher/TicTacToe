//
//  Generic.swift
//  rxbuttontaptest
//
//  Created by Maarten Schumacher on 1/9/16.
//  Copyright © 2016 Maarten Schumacher. All rights reserved.
//

import Foundation
import RxSwift

infix operator |> { associativity left }

func |> <A,B,C> (lhs: A -> B, rhs: B -> C) -> (A -> C) {
    return { a in
        rhs(lhs(a))
    }
}

func |> <T,U> (lhs: T, rhs: T -> U) -> U {
    return rhs(lhs)
}

extension ObservableType {
    func scanWithStart<T>(seed: T, accumulator: (T, Self.E) -> T) -> Observable<T> {
        return self.scan(seed, accumulator: accumulator)
            .startWith(seed)
    }
}