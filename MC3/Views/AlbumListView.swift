//
//  AlbumListView.swift
//  MC3
//
//  Created by Wahyu Alfandi on 19/07/23.
//

import SwiftUI

struct AlbumListView: View {
    @EnvironmentObject var router: Router
    struct MyPath: Shape {
        let size = UIScreen.main.bounds
        func path(in rect: CGRect) -> Path {
                var path = Path()
                path.move(to: .zero)
                path.addLine(to: CGPoint(x: -10, y: 282))
            path.addCurve(to: CGPoint(x: UIScreen.main.bounds.width+10, y: 282), control1: CGPoint(x:-10 , y: 282+95), control2: CGPoint(x:size.width+10 , y: 282+95))
            path.addLine(to: CGPoint(x: size.width+10, y: 0))
                path.addLine(to: .zero)
                path.closeSubpath()
            return path
        }
    }
    
    var body: some View {
            VStack{
                Spacer()
                    .frame(height: 310)
                Text("Check out the audio in\nthis collection!")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.system(size: 20, weight: .bold))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.neutral)
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
                                
                            }
                            .padding(.top, item == Album.mockAlbums.first ? 16 : 27)
                    }
                }
            }
        
        .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height)
        
        .background{
            ZStack{
                VStack{
                    NetworkImage(imageUrl: "https://images.unsplash.com/photo-1576158114254-3ba81558b87d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1480&q=80", width: UIScreen.main.bounds.width, height: 400)
                        .clipShape(MyPath())
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
