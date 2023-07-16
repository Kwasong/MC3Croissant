//
//  SecondaryButton.swift
//  MC3
//
//  Created by Wahyu Alfandi on 15/07/23.
//

import SwiftUI

struct SecondaryButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title).font(.body)
                .foregroundColor(.neutral)
                .padding(.vertical, 9)
                .padding(.horizontal, 74)
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(.teal, lineWidth: 2)
                )
             
        }
    }
}

struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        SecondaryButton(title: "Continue") {
            print("haha")
        }
    }
}
