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
    
    var body: some View {
        HStack{
            HStack{
                
                Image(album.imageUrl ?? "")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 60)
                    .cornerRadius(10)
                    .padding(.trailing, 10)
                
                VStack(alignment: .leading, spacing: 0){
                    Text(album.title ?? "Title")
                        .font(.system(size: 17))
                        .foregroundColor(.neutral)
                    Text("^[\(album.numOfTrack ?? 0) Track](inflect: true)   •   \(album.numOfMinutes ?? 0) min")
                        .font(.system(size: 12))
                        .foregroundColor(.neutral)
                }
            }.onTapGesture {
                viewModel.selectedAlbum = album
                router.push(.musicPlayer(data: album))
            }
            
            Spacer()
            Image(systemName: "chevron.right"  )
        }.padding(.horizontal, 50)
    }
    
}

struct AlbumItemCard_Previews: PreviewProvider {
    static var previews: some View {
        AlbumItemCard(album: .mockAlbums[0])
    }
}
