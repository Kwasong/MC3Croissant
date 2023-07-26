//
//  ShuffleButton.swift
//  MC3
//
//  Created by Sha Nia Siahaan on 25/07/23.
//

import SwiftUI

struct ShuffleButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "shuffle.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(.myTeal as Color)
        }
    }
}

struct ShuffleButton_Previews: PreviewProvider {
    static var previews: some View {
        ShuffleButton {
            print("shuffle")
        }
    }
}
