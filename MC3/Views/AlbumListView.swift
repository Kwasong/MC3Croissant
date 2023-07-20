//
//  AlbumListView.swift
//  MC3
//
//  Created by Wahyu Alfandi on 19/07/23.
//

import SwiftUI

struct AlbumListView: View {
    var body: some View {
            VStack{
                Spacer()
                    .frame(height: 300)
                
                Text("Check out the audio in\nthis collection!")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.system(size: 20, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.neutral)
                Text("Album")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.neutral)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 37)
                    .padding(.horizontal, 50)
                
                ScrollView{
                    ForEach(Album.mockAlbums, id: \.id){ item in
                        AlbumItemCard(album: item)
                            .padding(.top, item == Album.mockAlbums.first ? 16 : 27)
                    }
                }
            }
        
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height)
        
        .background{
            ZStack{
                VStack{
                    Circle()
                        .frame(width: 612, height: 612)
                        .position(x: UIScreen.main.bounds.width/2, y: 0)
                        .foregroundColor(.lightTeal as Color)
                    Spacer()
                }
            }.ignoresSafeArea()
            
                
            
        }
    }
}

struct AlbumListView_Previews: PreviewProvider {
    static var previews: some View {
        AlbumListView()
    }
}
