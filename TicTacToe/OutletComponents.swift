//
//  OutletComponents.swift
//  rxbuttontaptest
//
//  Created by Maarten Schumacher on 1/9/16.
//  Copyright © 2016 Maarten Schumacher. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct ButtonComponent: OutletComponent {
    let outlet: UIButton
    
    var input: Observable<()> {
        return outlet.rx_tap.map { _ in () }
    }
    
    func applyState(state: Observable<String>) -> Disposable {
        return state
            .subscribeNext { string in
                self.outlet.setTitle(string, forState: .Normal)
            }
    }
}

struct LabelComponent: OutletComponent {
    let outlet: UILabel!
    
    func applyState(state: Observable<String>) -> Disposable {
        return state
            .subscribeNext {
                self.outlet.text = $0
        }
    }
    
    var input: Observable<()> {
        return just(())
    }
}
