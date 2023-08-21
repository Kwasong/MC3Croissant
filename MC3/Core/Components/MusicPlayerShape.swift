//
//  MusicPlayerShape.swift
//  MC3
//
//  Created by Wahyu Alfandi on 21/07/23.
//

import SwiftUI

struct MusicPlayerShape: Shape {
    let size = UIScreen.main.bounds
    func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: .zero)
        path.addLine(to: CGPoint(x: -20, y: 284.5))
        path.addCurve(to: CGPoint(x: UIScreen.main.bounds.width+20, y: 284.5), control1: CGPoint(x:-20 , y: 284.5+150), control2: CGPoint(x:size.width+20 , y: 284.5+150))
        path.addLine(to: CGPoint(x: size.width+20, y: 0))
            path.addLine(to: .zero)
            path.closeSubpath()
        return path
    }
}


struct MusicPlayerShape_Previews: PreviewProvider {
    static var previews: some View {
        MusicPlayerShape()
    }
}
