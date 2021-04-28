//
//  HelloReduxApp.swift
//  HelloRedux
//
//  Created by Muang on 25/4/2564 BE.
//

import SwiftUI

@main
struct HelloReduxApp: App {
    var body: some Scene {
        let store = Store(reducer: reducer, middlewares: [logMiddleware()])
        WindowGroup {
            ContentView().environmentObject(store)
        }
    }
}
