//
//  PersonalityPicker.swift
//  MC3
//
//  Created by Wahyu Alfandi on 28/07/23.
//

import SwiftUI

struct PersonalityPicker: View {
    @AppStorage("personality") var personality: String = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text("PERSONALITY")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(.neutral)
                .padding(.horizontal, 12)
                .padding(.vertical, 7)
            Divider()
            
            HStack{
                Image("Nice")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .overlay {
                        Circle().stroke(Color("teal"), lineWidth: 4)
                            .frame(width: 40, height: 40)
                    }
                Text("Friendly")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.neutral)
                    .padding(.leading, 16)
                Spacer()
                Image(systemName: "checkmark")
                    .opacity(personality == "friendly" ? 1 : 0)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .onTapGesture {
                personality = "friendly"
            }
            
            Divider()
            
            HStack{
                Image("Sassy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .overlay {
                        Circle().stroke(Color("teal"), lineWidth: 4)
                            .frame(width: 40, height: 40)
                    }
                Text("Sassy")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.neutral)
                    .padding(.leading, 16)
                
                Spacer()
                Image(systemName: "checkmark")
                    .opacity(personality == "sassy" ? 1 : 0)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .onTapGesture {
                personality = "sassy"
            }
        }
        .background(Color("bgColor"))

        .frame(width: 190)
        .cornerRadius(14)
    }
}

struct PersonalityPicker_Previews: PreviewProvider {
    static var previews: some View {
        PersonalityPicker()
    }
}
