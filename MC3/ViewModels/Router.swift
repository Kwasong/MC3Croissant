//
//  Router.swift
//  MC3
//
//  Created by Wahyu Alfandi on 16/07/23.
//

import SwiftUI

enum Route: Hashable{
    case onboarding
    case test(data: Int)
}

final class Router: ObservableObject{
    @Published  var path = NavigationPath()
    
    public func toRoot(){
        path = .init()
    }
    
    public func pop(){
        if path.count <= 1{
            return
        }
        path.removeLast(1)
    }
    
    public func push(_ T: any Hashable){
        path.append(T)
    }
}
