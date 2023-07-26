//
//  MusicPlayerView.swift
//  MC3
//
//  Created by Wahyu Alfandi on 21/07/23.
//

import SwiftUI

struct MusicPlayerView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var viewModel: MusicViewModel
    let album: Album
    
    var body: some View {
        VStack(spacing: 0){
            Spacer().frame(height: 385)
            Text(viewModel.selectedAlbum?.title ?? "Title")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.neutral)
                .padding(.top, 24)
            Text(viewModel.selectedAlbum?.artist ?? "Artist")
                .font(.system(size: 14))
                .foregroundColor(.neutral)
            
            HStack(spacing: 44){
                Button{
                    viewModel.isOnShuffle.toggle()
                } label: {
                    Image(systemName: "shuffle")
                        .foregroundColor(
                            viewModel.isOnShuffle ? .teal60 : .neutral)
                }
                Button{
                    viewModel.playPreviousSound()
                } label: {
                    Image(systemName: "backward.fill")
                        .foregroundColor(
                            viewModel.isOnShuffle ? .neutral :
                            viewModel.isPrevSoundExist() ?
                            .neutral : .neutral10
                        )
                    
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
                    //check if next sound exist or prev sound exist
                    viewModel.playNextSound()
                } label: {
                    Image(systemName: "forward.fill")
                        .foregroundColor(
                            viewModel.isOnShuffle ? .neutral :
                            viewModel.isNextSoundExist() ?
                            .neutral : .neutral10
                        )
                }
                Button{
                    viewModel.toggleRepeat()
                    print(viewModel.isRepeatOn)
                } label: {
                    Image(systemName: "repeat")
                        .foregroundColor(viewModel.isRepeatOn ?  .teal60: .neutral)
                }
            }
            .padding(.top, 20)
            
            ScrollView{
                
                if let sounds = viewModel.selectedAlbum?.sounds {
                    VStack(spacing: 0){
                        ForEach(0..<sounds.count){ index in
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
                                    
                                    viewModel.stopAudio()
                                    viewModel.prepareAudio(track: sounds[index].soundPath ?? "")
                                    viewModel.soundIndex = index
                                    viewModel.playAudio()
                                    
                                } label: {
                                    Image(systemName: viewModel.soundIndex == index && viewModel.isPlaying ? "pause.fill" : "play.fill")
                                        .foregroundColor(.neutral)
                                }
                            }
                            .padding(.leading, 16)
                            .padding(.trailing, 20)
                            .padding(.vertical, 12)
                            .background(.lightTeal.opacity(0.4) as Color)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                            .padding(.top, 14)
                        }
                        
                    }.padding(.top, 22)
                }
            }
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay{
            ZStack(alignment: .topLeading){
                VStack{
                    NetworkImage(imageUrl: viewModel.selectedAlbum?.imageUrl ?? "", width: UIScreen.main.bounds.width, height: 400)
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
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Button{
                        viewModel.stopAudio()
                        viewModel.reset()
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
            if viewModel.isPlaying{
                viewModel.stopAudio()
            }else {
                if let sound =
                    viewModel.selectedAlbum?.sounds[viewModel.soundIndex] {
                    viewModel.prepareAudio(track: sound.soundPath!)
                    viewModel.playAudio()
                }else {
                    print("sound doesnt exist")
                }
            }
            

        }
        .onChange(of: viewModel.navigateToNextView){ newValue in
            if newValue == true {
                viewModel.reset()
                router.push(.assestmentView(lastMethod: .sound))
            }
            
        }
        
        .ignoresSafeArea()
    }
}


