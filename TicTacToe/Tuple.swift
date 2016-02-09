//
//  Tuple.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 1/10/16.
//  Copyright © 2016 Maarten Schumacher. All rights reserved.
//

import Foundation


protocol TupleType {
    typealias T
    typealias U
    
    var fst: T { get }
    var snd: U { get }
}

extension TupleType {
    func fstMap<R>(closure: T -> R) -> Tuple<R, U> {
        return Tuple(fst: closure(self.fst), snd: self.snd)
    }
    
    func sndMap<S>(closure: U -> S) -> Tuple<T, S> {
        return Tuple(fst: self.fst, snd: closure(self.snd))
    }
    
    func bothMap<R, S>(closure: (T, U) -> (R, S)) -> Tuple<R, S> {
        let (newFst, newSnd) = closure(self.fst, self.snd)
        return Tuple(fst: newFst, snd: newSnd)
    }
}

struct Tuple<T,U>: TupleType {
    let (fst, snd): (T, U)
    
    var both: (T, U) {
        return (fst, snd)
    }
}
