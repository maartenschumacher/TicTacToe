//
//  Rules.swift
//  TicTacToe
//
//  Created by Maarten Schumacher on 12/19/15.
//  Copyright © 2015 Maarten Schumacher. All rights reserved.
//

import Foundation

struct Rule {
    let analysis: GridLineAnalysis
    let priority: (Player) -> (Priority)
}

let rules: [Rule] = [
    
    Rule(
        analysis: GridLineAnalysis(
            empties: 1,
            circles: 2,
            crosses: 0
        ),
        priority: { (player: Player) -> Priority in
            return player.returnIf(cross: .High, circle: .Highest)
        }
    ),
    
    Rule(
        analysis: GridLineAnalysis(
            empties: 1,
            circles: 0,
            crosses: 2
        ),
        priority: { (player: Player) -> Priority in
            return player.returnIf(cross: .Highest, circle: .High)
        }
    ),
    
    Rule(
        analysis: GridLineAnalysis(
            empties: 1,
            circles: 1,
            crosses: 1
        ),
        priority: { _ in .Lowest }
    )
    
]