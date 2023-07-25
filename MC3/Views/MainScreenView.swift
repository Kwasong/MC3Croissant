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
            
            
            
            
            
        }.padding(27)
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
