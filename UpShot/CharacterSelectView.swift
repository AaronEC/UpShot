//
//  CharacterSelectView.swift
//  UpShot
//
//  Created by Aaron Cardwell on 14/01/2022.
//

import SwiftUI

struct CharacterSelectView: View {

    @State private var selectedTab = "0"
    var noOfImages = 3
    var userName: String
    var charNames:[String] = ["Joey","Sarah", "Aiza"]

    var body: some View {
        VStack {
            Text("Welcome " + userName)
                .font(.system(size: 32, weight: .bold))
                .multilineTextAlignment(.center)

            GeometryReader{ proxy in

                TabView (selection: $selectedTab){

                    ForEach(0..<noOfImages) {num in
                        VStack{
                            Image("Character" + String(num))
                                .resizable()
                                .scaledToFit()
                            
                            Text(charNames[num])
                            Image("Star" + String(num))
                                .resizable()
                                .frame(width: 192, height: 64)
                        }
                        .tag(String(num))
                        .padding(.bottom, 50)
                    }

                }
                .tabViewStyle(PageTabViewStyle())
                .padding()
                .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
                .background(Color("AltColour"))
            }

            Text("Select your opponent!")
                .padding()
                .font(.system(size: 24, weight: .bold))

            NavigationLink(destination: MatchView(userName: userName, charNames: charNames, charID: selectedTab), label: {Text("Begin Match!")
                    .bold()
                    .frame(width: 280, height: 50)
                    .background(Color("AccentColour"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            })
        }
    }
}
