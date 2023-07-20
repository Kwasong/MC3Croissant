//
//  AlbumItemCard.swift
//  MC3
//
//  Created by Wahyu Alfandi on 19/07/23.
//

import SwiftUI

struct AlbumItemCard: View {
    let album: Album
    
    var body: some View {
        HStack{
            NetworkImage(imageUrl: album.imageUrl ?? "", width: 70, height: 60, cornerRadius: 10)
                .padding(.trailing, 10)
            
            VStack(alignment: .leading, spacing: 0){
                Text(album.title ?? "Title")
                    .font(.system(size: 17))
                    .foregroundColor(.neutral)
                Text("^[\(album.numOfTrack ?? 0) Track](inflect: true)   •   ^[\(album.numOfMinutes ?? 0) min](inclect: true)")
                    .font(.system(size: 12))
                    .foregroundColor(.neutral)
            }
            Spacer()
            Image(systemName: album.isFavorite ? "heart.fill" : "heart")
        }.padding(.horizontal, 50)
    }
}

struct AlbumItemCard_Previews: PreviewProvider {
    static var previews: some View {
        AlbumItemCard(album: Album.mockAlbums[1])
    }
}
