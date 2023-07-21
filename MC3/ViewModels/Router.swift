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
    case assestmentView(lastMethod: Method)
    case result(lastMethod: Method)
    case test(data: Int)
    
}

final class Router: ObservableObject{
    @Published  var path = NavigationPath()
    
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
