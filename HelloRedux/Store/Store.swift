//
//  Store.swift
//  HelloRedux
//
//  Created by Muang on 25/4/2564 BE.
//

import Foundation

typealias Dispatcher = (Action) -> Void
typealias Reducer = (_ state: State, _ action: Action) -> State
typealias Middleware = (State, Action, @escaping Dispatcher) -> Void

struct State {
    var counter: Int = 0
}

protocol Action { }

struct IncrementAction: Action { }
struct DecrementAction: Action { }

struct AddAction: Action {
    let value: Int
}

func reducer(_ state: State, _ action: Action) -> State {
    var state = state

    switch action {
    case _ as IncrementAction:
        state.counter += 1
    case _ as DecrementAction:
        state.counter -= 1
    case let action as AddAction:
        state.counter += action.value
    default:
        break
    }

    return state
}

func logMiddleware() -> Middleware {
    return { state, action, dispatch in
        print("[LOG MIDDLEWARE] \(action)")
    }
}

class Store: ObservableObject {
    var reducer: Reducer
    @Published var state: State
    var middlewares: [Middleware]

    init(reducer: @escaping Reducer, state: State = State(), middlewares: [Middleware] = []) {
        self.reducer = reducer
        self.state = state
        self.middlewares = middlewares
    }

    func dispatch(action: Action) {
        state = reducer(state, action)
        
        // run all middlewares
        middlewares.forEach { middleware in
            middleware(state, action, dispatch)
        }
    }
}
