//
//  AlbumListView.swift
//  MC3
//
//  Created by Wahyu Alfandi on 19/07/23.
//

import SwiftUI

struct AlbumListView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var viewModel: MusicViewModel
    
    var body: some View {
        VStack{
            Spacer()
                .frame(height: 305)
            Text("Check out the audio in\nthis collection!")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(.system(size: 20, weight: .bold))
                .multilineTextAlignment(.center)
                .foregroundColor(.neutral)
                .padding(.top, 44)
            Text("Album")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.neutral)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 32)
                .padding(.horizontal, 50)
            
            ScrollView{
                ForEach(viewModel.albums, id: \.id){ item in
                    AlbumItemCard(album: item)
                        .padding(.top, item == viewModel.albums.first ? 16 : 27)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height)
        
        .overlay{
            ZStack{
//                q
                Image("musicGhone")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 224)
                    .padding(.bottom, 300)
                VStack{
                    HStack{
                        Button{
                            router.pop()
                        }label: {
                            Image(systemName: "chevron.left.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 48, height: 48)
                                .foregroundColor(.teal60 as Color)
                        }
                        
                        Spacer()
                        
                        Button{
                            viewModel.stopAudio()
                            viewModel.reset()
                            router.push(.assestmentView(lastMethod: .musicPlayer))
                        }label: {
                            Text("Done")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                }
                
                
            }.ignoresSafeArea()
        }
        
    }
}

struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView()
            .environmentObject(Router())
            .environmentObject(MusicViewModel())
    }
}

