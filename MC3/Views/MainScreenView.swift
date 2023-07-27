//
//  MainScreenView.swift
//  MC3
//
//  Created by Safik Widiantoro on 24/07/23.
//

import SwiftUI

struct MainScreenView: View {
    var body: some View {
        VStack{
            Section{
                HStack{
                    Text("Hello, (Nama)")
                    Image("Nice")
                }
            }
            Section{
                Text("Guided Activity")
//                Rectangle()
//                    .frame(maxHeight: 200)
//                    .cornerRadius(20)
//                    .overlay{
                        ZStack{
                            Circle()
                                .frame(width: 300)
                                .foregroundColor(Color.yellow)
                            Circle()
                                .frame(width: 300)
                                .foregroundColor(Color.green)
                                .padding(.trailing, -40)
                            Circle()
                                .frame(width: 300)
                                .foregroundColor(Color.gray)
                                .padding(.trailing, -80)
                            
                            Circle()
                                .frame(width: 300)
                                .foregroundColor(Color.blue)
                                .padding(.trailing, -120)
//                        }
                        }
                        .background{
                            Color.black
                        }
            }
            Section{
                VStack{
                    Text("Personal Mix")
                    Section{
                        Rectangle()
                            .frame(maxHeight: 120)
                        Rectangle()
                            .frame(maxHeight: 120)
                        Rectangle()
                            .frame(maxHeight: 120)
                    }.cornerRadius(8)
                }
            }
            
            
<<<<<<< HEAD
            
            
            
        }.padding(27)
=======
            Section{
                Rectangle()
                    .frame(maxHeight: 120)
                    .onTapGesture {
                        router.push(.breathingView)
                    }
                    .foregroundColor(Color.teal30)
                    .overlay{
                        HStack{
                            VStack(alignment: .leading){
                                Text("Breathe With Me")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 18))
                                Text("Try the “4-7-8 breathing technique” to calm yourself down")
                                    .fontWeight(.light)
                                    .font(.system(size: 12))
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
                
                
                Rectangle()
                    .frame(maxHeight: 120)
                    .onTapGesture {
                        router.push(.albumListView)
                    }
                    .foregroundColor(Color.teal30)
                    .overlay{
                        HStack{
                            VStack(alignment: .leading){
                                Text("Relaxing Audio")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 18))
                                Text("Play the collections of relaxing audio to ease your mind")
                                    .fontWeight(.light)
                                    .font(.system(size: 12))
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
                    .onTapGesture {
                        router.push(.riddleView)
                    }
                    .foregroundColor(Color.teal30)
                    .overlay{
                        HStack{
                            VStack(alignment: .leading){
                                Text("Riddles")
                                    .fontWeight(.semibold)
                                    .font(.system(size: 18))
                                Text("Enjoy some riddles to have some fun and bring smile to your face")
                                    .fontWeight(.light)
                                    .font(.system(size: 12))
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
            }.cornerRadius(8)
        }
        .padding(26)
        .navigationBarBackButtonHidden()
        
        
>>>>>>> ba3014d (add hidden back button view)
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
