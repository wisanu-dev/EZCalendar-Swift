//
//  Router.swift
//  Demo
//
//  Created by Wisanu Paunglumjeak on 12/1/2568 BE.
//

import SwiftUI

class Router: ObservableObject {
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: any Hashable) {
        navPath.append(destination)
    }

    func navigateBack() {
        navPath.removeLast()
    }

    func navigateBack(stackCount: Int) {
        navPath.removeLast(stackCount)
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
    
    func isRoot() -> Bool {
        navPath.count == 1
    }
}
