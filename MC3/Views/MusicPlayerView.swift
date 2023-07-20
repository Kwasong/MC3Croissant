//
//  MusicPlayerView.swift
//  MC3
//
//  Created by Wahyu Alfandi on 21/07/23.
//

import SwiftUI

struct MusicPlayerView: View {
    let album: Album
    var body: some View {
        VStack(spacing: 0){
            Spacer().frame(height: 385)
            Text(album.title ?? "Title")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.neutral)
                .padding(.top, 24)
            Text(album.artist ?? "Artist")
                .font(.system(size: 14))
                .foregroundColor(.neutral)
            
            HStack(spacing: 44){
                Button{
                    
                } label: {
                    
                    Image(systemName: "shuffle")
                        .foregroundColor(.neutral)
                }
                Button{
                    
                } label: {
                    
                    Image(systemName: "backward.fill")
                        .foregroundColor(.neutral)
                }
                Button{
                    
                } label: {
                    
                    Image(systemName: "pause.fill")
                        .foregroundColor(.neutral)
                }
                Button{
                    
                } label: {
                    
                    Image(systemName: "forward.fill")
                        .foregroundColor(.neutral)
                }
                Button{
                    
                } label: {
                    
                    Image(systemName: "repeat")
                        .foregroundColor(.neutral)
                }
            }
            .padding(.top, 20)
            
            ScrollView{
                ForEach(Sound.mockSounds, id: \.id){ item in
                    SoundItemCard(sound: item)
                        .padding(.bottom, 6)
                        .padding(.horizontal, 40)
    //                    .padding(.bottom, 14)
                }
                .padding(.top, 22)
            }
            Spacer()
            
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background{
            VStack{
                NetworkImage(imageUrl: album.imageUrl ?? "", width: UIScreen.main.bounds.width, height: 400)
                    .clipShape(MusicPlayerShape())
                Spacer()
            }.ignoresSafeArea()
        }
        .ignoresSafeArea()
    }
}
