//
//  ContentView.swift
//  UpShot
//
//  Created by Aaron Cardwell on 07/01/2022.
//

import SwiftUI

struct HomeView: View {
    
    @State private var userName: String = ""
    
    var body: some View {
        NavigationView {
            VStack{

                Image("cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 20)
                    .scaledToFit()

                Spacer()

                TextField(
                    "Archer's Name",
                    text: $userName
                )
                    .disableAutocorrection(true)
                    .textFieldStyle(.roundedBorder)
                    .font(Font.system(size: 28))
                    .foregroundColor(.black)
                    .cornerRadius(10)
                    .shadow(radius: 10)
                    .frame(width: 280, height: 50)
                    .multilineTextAlignment(.center)

                NavigationLink(destination: CharacterSelectView(userName: userName), label: {Text("Start Match")
                        .bold()
                        .frame(width: 280, height: 50)
                        .background(Color("AccentColour"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })

                NavigationLink(destination: OptionView(color: .red), label: {Text("Options")
                        .bold()
                        .frame(width: 280, height: 50)
                        .background(Color("MainColour"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })

                Spacer()
            }
            .navigationBarTitle("")
        }
        .accentColor(Color(.label))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            ResultsView(result: "Draw", score: "23 - 45", username: "Aaron")
            HomeView()
//            CharacterSelectView(userName: "Aaron")
//            MatchView(userName: "Aaron", charNames: ["Joey","Sarah", "Beth"], charID: "0")
        }
    }
}
