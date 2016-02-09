//
//  ComponentFactory.swift
//  rxbuttontaptest
//
//  Created by Maarten Schumacher on 1/19/16.
//  Copyright © 2016 Maarten Schumacher. All rights reserved.
//

import Foundation
import RxSwift

class ComponentFactory<State, Event> {
    let disposeBag = DisposeBag()
    
    init(initialState: State, flow: [ComponentFlow<State, Event>], transform: Observable<Event> -> Observable<State>) {
        let proxyOutput = Output(initialState: initialState)
        let realOutput = flow
            .map { singleFlow in
                singleFlow.input(proxyOutput.get())
            }
            .toObservable().merge()
            |> transform
        
        proxyOutput.add(realOutput)
        flow.forEach { singleFlow in
            singleFlow.disposable(realOutput)
                .addDisposableTo(self.disposeBag)
        }
    }
    
    convenience init(initialState: State, flow: [[ComponentFlow<State, Event>]], transform: Observable<Event> -> Observable<State>) {
        let flattenedFlow = flow.reduce([], combine: +)
        self.init(initialState: initialState, flow: flattenedFlow, transform: transform)
    }
}