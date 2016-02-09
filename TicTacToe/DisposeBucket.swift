//
//  DisposeBag.swift
//  rxbuttontaptest
//
//  Created by Maarten Schumacher on 1/6/16.
//  Copyright © 2016 Maarten Schumacher. All rights reserved.
//

import Foundation

class DisposeBucket {
    private var refs = [AnyObject]()
    
    func add(object: AnyObject) {
        refs.append(object)
    }
}