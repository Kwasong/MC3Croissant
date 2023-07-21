//
//  SoundItemCard.swift
//  MC3
//
//  Created by Wahyu Alfandi on 21/07/23.
//

import SwiftUI

struct SoundItemCard: View {
    let sound: Sound
    var body: some View {
        HStack(spacing: 0){
            Text("1.")
                .font(.system(size: 14, weight: .bold))
                .padding(.trailing, 13)
            VStack(alignment: .leading, spacing: 0){
                Text(sound.title ?? "Title Placeholder").font(.system(size: 14, weight: .bold))
                    .foregroundColor(.neutral)
                Text(sound.author ?? "Author Placeholder").font(.system(size: 10))
                    .foregroundColor(.neutral)
                
            }
            Spacer()
            Button{
                
            } label: {
                Image(systemName: "play.fill")
                    .foregroundColor(.neutral)
            }
        }
        .padding(.leading, 16)
        .padding(.trailing, 20)
        .padding(.vertical, 12)
        .background(.lightTeal.opacity(0.4) as Color)
        .cornerRadius(10)
        
    }
}

struct SoundItemCard_Previews: PreviewProvider {
    static var previews: some View {
        SoundItemCard(sound: Sound(albumId: UUID().uuidString, title: "Title", author: "author", soundPath: "blabla"))
    }
}
