//
//  AlbumListViewModel.swift
//  MC3
//
//  Created by Wahyu Alfandi on 23/07/23.
//

import Foundation

@MainActor final class AlbumListViewModel: ObservableObject {
    @Published var albums: [Album] = Album.mockAlbums
}
