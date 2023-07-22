//
//  TestView.swift
//  MC3
//
//  Created by Wahyu Alfandi on 20/07/23.
//

import SwiftUI

struct CustomPath: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        // Define your custom path here
        let cornerRadius: CGFloat = 20
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius), radius: cornerRadius, startAngle: .init(degrees: -90), endAngle: .zero, clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
        path.addArc(center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: .zero, endAngle: .init(degrees: 90), clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY))
        path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius), radius: cornerRadius, startAngle: .init(degrees: 90), endAngle: .init(degrees: 180), clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        path.addArc(center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius), radius: cornerRadius, startAngle: .init(degrees: 180), endAngle: .init(degrees: 270), clockwise: false)

        return path
    }
}

struct TestView: View {
    var body: some View {
            ZStack {
                // Background content
                

                // Custom shape as a clipped mask
                Image("ghone")
                    .resizable()
                    .frame(width: 200, height:200)
                    .scaledToFill()
//                    .fill(Color.blue)
                    .frame(width: 150, height: 150)
                    .clipShape(CustomPath())
            }
        }
}


struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
