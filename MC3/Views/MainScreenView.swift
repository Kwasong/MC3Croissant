//
//  MainScreenView.swift
//  MC3
//
//  Created by Safik Widiantoro on 24/07/23.
//

import SwiftUI

struct MainScreenView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack(alignment: .leading){
            Section{
                HStack{
                    Text("Hello, (Nama)")
                        .bold()
                        .font(.system(size: 34))
                    Spacer()
                    Image("Nice")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                }
            }
            
            Text("Guided Activity")
                .font(.system(size: 18))
                .bold()
            
            Section{
                VStack{
                    Image("mainBg")
                        .resizable()
                        .frame(height: 160)
                        .roundedCorner(20, corners: [.topLeft, .topRight])
                    ZStack{
                        Rectangle()
                            .frame(height: 64)
                            .roundedCorner(20, corners: [.bottomLeft, .bottomRight])
                            .foregroundColor(Color.teal60)
                        HStack{
                            Spacer()
                            Text("Talk With Ghone")
                                .bold()
                                .font(.system(size: 22))
                            Image(systemName: "play.fill")
                        }.foregroundColor(Color.white)
                            .padding()
                        
                    }
                    
                }
            }.onTapGesture {
                router.push(.comfortingView)
            }
            
            Text("Personal Mix")
                .font(.system(size: 18))
                .bold()
            
            Section{
                Rectangle()
                    .frame(maxHeight: 120)
                    .foregroundColor(Color.teal30)
                    .overlay{
                        HStack{
                            VStack(alignment: .leading){
                                Text("Breathe With Me")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 18))
                                Text("Try the “4-7-8 breathing technique” to calm yourself down")
                            }
                            ZStack{
                                Circle()
                                    .foregroundColor(Color.white.opacity(0.3))
                                    .frame(width: 66.67)
                                Circle()
                                    .foregroundColor(Color.white.opacity(0.5))
                                    .frame(width: 56.67)
                                Circle()
                                    .foregroundColor(Color.white.opacity(0.9))
                                    .frame(width: 46.67)
                                Image("sleepGhone")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 34, height: 37)
                            }
                            
                        }.padding()
                    }
                    .onTapGesture {
                        router.push(.breathingView)
                    }
                
                Rectangle()
                    .frame(maxHeight: 120)
                    .foregroundColor(Color.teal30)
                    .overlay{
                        HStack{
                            VStack(alignment: .leading){
                                Text("Breathe With Me")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 18))
                                Text("Try the “4-7-8 breathing technique” to calm yourself down")
                            }
                            ZStack{
                                Circle()
                                    .foregroundColor(Color.white.opacity(0.3))
                                    .frame(width: 66.67)
                                Circle()
                                    .foregroundColor(Color.white.opacity(0.5))
                                    .frame(width: 56.67)
                                Circle()
                                    .foregroundColor(Color.white.opacity(0.9))
                                    .frame(width: 46.67)
                                Image("musicGhone")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 34, height: 37)
                            }
                            
                        }.padding()
                    }
                
                
                
                Rectangle()
                    .frame(maxHeight: 120)
                    .foregroundColor(Color.teal30)
                    .overlay{
                        HStack{
                            VStack(alignment: .leading){
                                Text("Breathe With Me")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 18))
                                Text("Try the “4-7-8 breathing technique” to calm yourself down")
                            }
                            ZStack{
                                Circle()
                                    .foregroundColor(Color.white.opacity(0.3))
                                    .frame(width: 66.67)
                                Circle()
                                    .foregroundColor(Color.white.opacity(0.5))
                                    .frame(width: 56.67)
                                Circle()
                                    .foregroundColor(Color.white.opacity(0.9))
                                    .frame(width: 46.67)
                                Image("ghone")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 34, height: 37)
                            }
                            
                        }.padding()
                    }
            }.cornerRadius(8)
        }.padding(26)
        
        
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
