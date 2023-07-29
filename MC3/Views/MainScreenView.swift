//
//  MainScreenView.swift
//  MC3
//
//  Created by Safik Widiantoro on 24/07/23.
//

import SwiftUI

struct MainScreenView: View {
    @AppStorage("name") var name: String = ""
    @AppStorage("personality") var personality: String = ""
    @EnvironmentObject var router: Router
    @State var pickerShown: Bool = false
    
    
    var body: some View {
        ZStack{
            content
            PersonalityPicker()
                .position(x: screenWidth * 0.7, y: 145)
                .animation(
                    .spring(response: 0.6, dampingFraction: 0.8),
                    value: pickerShown
                )
                .opacity(pickerShown ? 1 : 0)
        }
        
        .navigationBarBackButtonHidden()
        
        
    }
}

extension MainScreenView{
    var content: some View {
        VStack(alignment: .leading){
            Section{
                HStack{
                    Text("Hello, \(name)")
                        .bold()
                        .font(.system(size: 34))
                    Spacer()
                    Image(personality == "friendly" ?  "Nice": "Sassy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40)
                        .onTapGesture {
                            pickerShown.toggle()
                        }
                    
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
            
            
                Rectangle()
                    .frame(maxHeight: 120)
                    .cornerRadius(8)
                    .foregroundColor(Color.teal30)
                    .overlay{
                        HStack{
                            VStack(alignment: .leading, spacing: 0){
                                Text("Breathe With Me")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 18))
                                Text("Try the “4-7-8 breathing technique” to calm yourself down")
                                    .fontWeight(.light)
                                    .font(.system(size: 12))
                                    .padding(.top, 8)
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
                    
                    .cornerRadius(8)
                    .foregroundColor(Color.teal30)
                    .overlay{
                        HStack{
                            VStack(alignment: .leading, spacing: 0){
                                Text("Relaxing Audio")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 18))
                                Text("Play the collections of relaxing audio to ease your mind")
                                    .fontWeight(.light)
                                    .font(.system(size: 12))
                                    .padding(.top, 8)
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
                    .onTapGesture {
                        router.push(.albumListView)
                    }
                
                
                
                Rectangle()
                    .frame(maxHeight: 120)
                    .cornerRadius(8)
                    .foregroundColor(Color.teal30)
                    .overlay{
                        HStack{
                            VStack(alignment: .leading, spacing: 0){
                                Text("Riddles")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 18))
                                Text("Enjoy some riddles to have some fun and bring smile to your face")
                                    .fontWeight(.light)
                                    .font(.system(size: 12))
                                    .padding(.top, 8)
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
                                Image("curiousGhone")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 34, height: 37)
                            }
                            
                        }.padding()
                    }
                    .onTapGesture {
                        router.push(.riddleView)
                    }
            
        }
        .padding(26)
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
            .environmentObject(Router())
    }
}
