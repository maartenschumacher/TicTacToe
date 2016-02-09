//
//  MutableSequence.swift
//  rxbuttontaptest
//
//  Created by Maarten Schumacher on 1/5/16.
//  Copyright © 2016 Maarten Schumacher. All rights reserved.
//

//  output can be a stream of observables, and consumers simply use the latest one

import Foundation
import RxSwift

class Output<T> {
    private let stream = PublishSubject<T>()
    
    init(initialState: T) {
        self.add(just(initialState))
    }
    
    func add(stream: Observable<T>) -> Disposable {
        return stream
            .subscribeNext {
                self.stream.onNext($0)
            }
    }
    
    func get() -> Observable<T> {
        return self.stream.asObservable()
    }
}

