//
//  Router.swift
//  MC3
//
//  Created by Wahyu Alfandi on 16/07/23.
//

import SwiftUI

enum Route: Hashable{
    case onboarding
    case musicPlayer(data: Album)
    case assestmentView
    case result(isStillScared: Bool)
    case breathingView
    case test(data: Int)
    case comfortingView
    case albumListView
    case riddleView
    case mainScreenView
}

final class Router: ObservableObject{
    @Published  var path = NavigationPath()
    @Published var lastMethod: Method = .fromMain
    
    public func toRoot(){
        path = .init()
    }
    
    public func pop(){
        
        path.removeLast()
    }
    
    public func push(_ route: Route){
        path.append(route)
    }
}
