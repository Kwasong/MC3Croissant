//
//  AlbumItemCard.swift
//  MC3
//
//  Created by Wahyu Alfandi on 19/07/23.
//

import SwiftUI

struct AlbumItemCard: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var viewModel : MusicViewModel
    
    var album: Album
    @State var isFavorite: Bool = false
    
    var body: some View {
        HStack{
            HStack{
                NetworkImage(imageUrl: album.imageUrl ?? "", width: 70, height: 60, cornerRadius: 10)
                    .padding(.trailing, 10)
                
                VStack(alignment: .leading, spacing: 0){
                    Text(album.title ?? "Title")
                        .font(.system(size: 17))
                        .foregroundColor(.neutral)
                    Text("^[\(album.numOfTrack ?? 0) Track](inflect: true)   •   \(album.numOfMinutes ?? 0)")
                        .font(.system(size: 12))
                        .foregroundColor(.neutral)
                }
            }.onTapGesture {
                viewModel.selectedAlbum = album
                router.push(.musicPlayer(data: album))
            }
            
            Spacer()
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .onTapGesture {
                        isFavorite.toggle()
                    
                }
        }.padding(.horizontal, 50)
            .task {
                isFavorite = album.isFavorite
            }
    }
    
}

struct AlbumItemCard_Previews: PreviewProvider {
    static var previews: some View {
        AlbumItemCard(album: .mockAlbums[0])
    }
}
