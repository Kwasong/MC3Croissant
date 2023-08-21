//
//  ToggleButton.swift
//  MC3
//
//  Created by Sha Nia Siahaan on 23/07/23.
//

import SwiftUI

struct ToggleButton: View {
    @State var isClicked: Bool = false
    var body: some View {
        ZStack{
            ZStack {
                Circle()
                    .fill(Color.clear)
                    .frame(width: 40)
                    .background(isClicked ? Image("Sassy-small") : Image("Nice-small"))
                    .offset(x: isClicked ? 20 : -20)
            }
            .frame(width: 90, height: 53)
            Capsule(style: .circular)
                .stroke(Color.teal55, lineWidth: 4.5)
                .frame(width: 90, height: 53)
        }
        .padding(.vertical, 50)
        .padding(.horizontal, 25)
        .onTapGesture {
            print("test")
            withAnimation(.easeInOut(duration: 2)) {
                isClicked.toggle()
            }
        }
    }
}

struct ToggleButton_Previews: PreviewProvider {
    static var previews: some View {
        ToggleButton()
    }
}
