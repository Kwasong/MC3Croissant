//
//  GeneralTextField.swift
//  MC3
//
//  Created by Wahyu Alfandi on 15/07/23.
//

import SwiftUI

struct GeneralTextField: View {
    @Binding var text: String
    let placeholder: String
    var body: some View {
        TextField(
            "",
            text: $text,
            prompt: Text(placeholder).font(.caption)
        )
        .frame(width: 210, height: 40)
        .multilineTextAlignment(.center)
        .background(.teal10 as Color)
        .cornerRadius(50)
        .overlay(
            RoundedRectangle(cornerRadius: 50)
                .stroke(.tealBase as Color, lineWidth: 1)
        )
        
        
    }
}

struct GeneralTextField_Previews: PreviewProvider {
    static var previews: some View {
        GeneralTextField(text: .constant(""), placeholder: "enter your name")
    }
}
