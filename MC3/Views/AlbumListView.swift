//
//  AlbumListView.swift
//  MC3
//
//  Created by Wahyu Alfandi on 19/07/23.
//

import SwiftUI

struct AlbumListView: View {
    @EnvironmentObject var router: Router
    
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
                    ForEach(Album.mockAlbums, id: \.id){ item in
                        AlbumItemCard(album: item)
                            .onTapGesture {
                                router.push(Route.musicPlayer(data: item))
                            }
                            .padding(.top, item == Album.mockAlbums.first ? 16 : 27)
                    }
                }
            }
        
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height)
        
        .background{
            ZStack{
                VStack{
                    Image("albumBg")
                        .resizable()
                        .scaledToFit()
                    Spacer()
                }
            }.ignoresSafeArea()
            
                
            
        }
    }
}