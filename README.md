# TicTacToe
Stateless Tic Tac Toe game with RxSwift

It’s a programming experiment in progress. 

In this project I want to explore two things: declarative vs. imperative programming, and stateless UI programming.

### Declarative vs Imperative

Declarative programming means describing what things are, and imperative programming means describing how they work. In this project, the declarative part would be the definition of types that represent a player, a playing field, a grid, a cross or circle, etc. The imperative part would be describing how the program should build and combine these types to achieve the desired behavior.

The goal in developing Tic Tac Toe is to reduce the imperative part to a minimum. The idea is that the imperative part (which lives in the components), consists solely of operations that are composed from functions defined in the declarative part.

### Stateless UI

A perfect program defines an initial state and, for every possible user input, defines methods to calculate a new state based on the preceding one. But when I was implementing this, I funnelled all my events through the central scan function in the view controller. To make it more flexible, I introduced components. Each component has an input and output stream. It’s job is to forward output (state) to its child components, and forward input (events) up to its parent component, and simply make the conversion between the types of events and state it handles.
