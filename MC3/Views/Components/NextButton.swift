//
//  NextButton.swift
//  MC3
//
//  Created by Wahyu Alfandi on 15/07/23.
//

import SwiftUI

struct NextButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.right.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.tealBase)
        }
    }
}

struct NextButton_Previews: PreviewProvider {
    static var previews: some View {
        NextButton{
            print("haha")
        }
    }
}
