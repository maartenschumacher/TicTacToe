//
//  Generic.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 12/13/15.
//  Copyright © 2015 Maarten Schumacher. All rights reserved.
//

import Foundation

func zip<T, U>(one one:[T], two: [U]) -> [(T,U)] {
    var result: [(T,U)] = []
    var i: Int = 0
    
    while (i < one.count) && (i < two.count) {
        result.append((one[i], two[i]))
        i += 1
    }
    
    return result
}