//
//  ComposableComponent.swift
//  rxbuttontaptest
//
//  Created by Maarten Schumacher on 1/6/16.
//  Copyright © 2016 Maarten Schumacher. All rights reserved.
//

import Foundation
import RxSwift

/*

composing a ComposableComponent with an OutputComponent closes the cycle.
this means: we apply the functions, returning an inputstream and disposable
we then need a top-level scan function, that takes this inputStream and
returns an outputStream, which wil be added to the proxy output

the API user needs to supply a flow, and a scan function, and an initial state.

*/

func |> <Parent: Component, Child: Component where Parent.ChildState == Child.State, Parent.ChildEvent == Child.Event>
    (lhs: Parent, rhs: Child)
    -> ComposableComponent<Parent.State, Parent.Event, Child.ChildState, Child.ChildEvent>
{
    return lhs.composable |> rhs
}

func |> <C: Component, Outlet: OutletComponent, S, E where Outlet.State == C.ChildState, Outlet.Event == C.ChildEvent, S == C.State, E == C.Event>
    (lhs: C, rhs: Outlet)
    -> [ComponentFlow<S,E>]
{
    return lhs.composable |> rhs
}

func |> <Child: Component, S, E>
    (lhs: ComposableComponent<S, E, Child.State, Child.Event>, rhs: Child)
    -> ComposableComponent<S, E, Child.ChildState, Child.ChildEvent>
{
    return ComposableComponent(
        inputTransform: { grandchildEvent, grandparentState in
            lhs.inputTransform(
                rhs.inputTransform(
                    grandchildEvent,
                    output: lhs.outputTransform(grandparentState)
                ),
                grandparentState
            )
        },
        outputTransform: lhs.outputTransform |> rhs.outputTransform
    )
}

func |> <Outlet: OutletComponent, S, E>
    (lhs: ComposableComponent<S, E, Outlet.State, Outlet.Event>, rhs: Outlet)
    -> [ComponentFlow<S,E>]
{
    return [ComponentFlow(
        disposable: { state in
            (lhs.outputTransform |> rhs.applyState)(state)
        },
        input: { proxyOutput in lhs.inputTransform(rhs.input, proxyOutput) }
    )]
}

// composing multiple components

func |> <Child: Component, S, E>
    (lhs: ComposableComponent<S,E,Child.State,Child.Event>, rhs: [Child])
    -> [ComposableComponent<S, E, Child.ChildState, Child.ChildEvent>]
{
    return rhs.map { component in
        lhs |> component
    }
}

func |> <Parent: Component, Child: Component where Parent.ChildState == Child.State, Parent.ChildEvent == Child.Event>
    (lhs: Parent, rhs: [Child])
    -> [ComposableComponent<Parent.State, Parent.Event, Child.ChildState, Child.ChildEvent>]
{
    return lhs.composable |> rhs
}

func |> <Outlet: OutletComponent, S, E>
    (lhs: [ComposableComponent<S, E, Outlet.State, Outlet.Event>], rhs: [Outlet])
    -> [ComponentFlow<S,E>]
{
    return zip(lhs, rhs).flatMap { component, outlet in
        component |> outlet
    }
}

func |> <C: Component, Outlet: OutletComponent where C.ChildState == Outlet.State, C.ChildEvent == Outlet.Event>
    (lhs: [C], rhs: [Outlet])
    -> [ComponentFlow<C.State, C.Event>]
{
    return lhs.map { $0.composable } |> rhs
}





