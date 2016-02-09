//
//  ComponentTypes.swift
//  rxbuttontaptest
//
//  Created by Maarten Schumacher on 1/19/16.
//  Copyright © 2016 Maarten Schumacher. All rights reserved.
//

import Foundation
import RxSwift

protocol Component {
    typealias State
    typealias Event
    typealias ChildState
    typealias ChildEvent
    
    func inputTransform(input: Observable<ChildEvent>, output: Observable<State>) -> Observable<Event>
    func outputTransform(output: Observable<State>) -> Observable<ChildState>
}

extension Component {
    var composable: ComposableComponent<Self.State, Self.Event, Self.ChildState, Self.ChildEvent> {
        return ComposableComponent(inputTransform: self.inputTransform, outputTransform: self.outputTransform)
    }
}

protocol OutletComponent {
    typealias State
    typealias Event
    
    var input: Observable<Event> { get }
    func applyState(state: Observable<State>) -> Disposable
}

struct ComponentFlow<State, Event> {
    let disposable: Observable<State> -> Disposable
    let input: Observable<State> -> Observable<Event>
}

struct ComposableComponent<S,E,CS,CE> {
    let inputTransform: (Observable<CE>, Observable<S>) -> Observable<E>
    let outputTransform: Observable<S> -> Observable<CS>
}

