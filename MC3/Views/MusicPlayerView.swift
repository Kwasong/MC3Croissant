//
//  MusicPlayerView.swift
//  MC3
//
//  Created by Wahyu Alfandi on 21/07/23.
//

import SwiftUI

struct MusicPlayerView: View {
    @EnvironmentObject var router: Router
    @StateObject var viewModel = MusicPlayerViewModel()
    @State var soundIndex: Int = 0
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
                    viewModel.stopAudio()
//                    viewModel.prepareAudio(track: album.so)
                } label: {
                    Image(systemName: "backward.fill")
                        .foregroundColor(.neutral)
                }
                Button{
                    if viewModel.isPlaying {
                        viewModel.pauseAudio()
                    } else {
                        viewModel.playAudio()
                    }
                } label: {
                    
                    Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
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
                ForEach(0..<Sound.mockSounds.count){ index in
                    HStack(spacing: 0){
                        Text("\(index + 1).")
                            .font(.system(size: 14, weight: .bold))
                            .padding(.trailing, 13)
                        VStack(alignment: .leading, spacing: 0){
                            Text(Sound.mockSounds[index].title ?? "Title Placeholder").font(.system(size: 14, weight: .bold))
                                .foregroundColor(.neutral)
                            Text(Sound.mockSounds[index].author ?? "Author Placeholder").font(.system(size: 10))
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
                    .padding(.horizontal, 40)
                    .padding(.top, 8)
                }
                .padding(.top, 22)
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay{
            ZStack(alignment: .topLeading){
                VStack{
                    NetworkImage(imageUrl: album.imageUrl ?? "", width: UIScreen.main.bounds.width, height: 400)
                        .overlay(.black.opacity(0.2))
                        .clipShape(MusicPlayerShape())
                        
                    Spacer()
                }
                .ignoresSafeArea()
                
                HStack{
                    Button{
                        router.pop()
                    }label: {
                        Image(systemName: "chevron.left.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 48, height: 48)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Button{
                        router.push(.assestmentView(lastMethod: .sound))
                    }label: {
                        Text("Skip")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 28)
                .padding(.vertical, 40)
            }
        }
        .onAppear{
            viewModel.prepareAudio(track: album.sounds.first?.soundPath ?? "summer-walk")
        }
        
        .ignoresSafeArea()
    }
}


