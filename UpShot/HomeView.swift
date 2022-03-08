//
//  ContentView.swift
//  UpShot
//
//  Created by Aaron Cardwell on 07/03/2022.
//

import SwiftUI

struct HomeView: View {
    
    @State private var userName: String = ""
    
    var body: some View {
        NavigationView {
            VStack{
                
                HomePageView()
                
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
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
                
                NavigationLink(destination: OptionsView(color: .red), label: {Text("Options")
                        .bold()
                        .frame(width: 280, height: 50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
                
                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .accentColor(Color(.label))
        
        
    }
}

struct MatchView: View {
    
    var userName: String
    
    var body: some View {
        VStack{
            
            Text("Match View")

        }
    }
}

struct CharacterSelectView: View {
    
    var noOfImages = 4
    var userName: String
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Welcome " + userName)
                    .padding()
                    .font(.system(size: 32, weight: .bold))
                    .multilineTextAlignment(.center)
                
                GeometryReader{ proxy in
                    TabView {
                        
                        ForEach(0..<noOfImages) {num in
                            Image("Character" + String(num))
                                .resizable()
                                .scaledToFit()
                                .tag(num)
                        }
                        
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .padding()
                    .accentColor(Color(.label))
                    .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
                }
                Text("Select your opponent!")
                    .padding()
                    .font(.system(size: 24, weight: .bold))
                
                NavigationLink(destination: CharacterSelectView(userName: userName), label: {Text("Begin Match!")
                        .bold()
                        .frame(width: 280, height: 50)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                })
            }
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}

struct OptionsView: View {
    
    var color: Color
    
    var body: some View {
        VStack{
            Text("Options Page")
        }
    }
}

struct HomePageView: View {
    var body: some View {
        
        Image("Logo_trans")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(.all)
            .scaledToFit()
            .frame(width: 320)
            .shadow(radius: 10)
        
        HStack {
            Image("Character2flip")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.leading, 40)
                .padding(.trailing, -10)
                .scaledToFit()
            Image("Character1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.trailing, 40)
                .padding(.leading, -10)
                .scaledToFit()
        
        }
        
        Spacer()
    }
}

struct TempView: View {
    
    var color: Color
    var number: Int
    
    var body: some View {
        Text("Match Page")
    }
//    var color: Color
//    var number: Int
//
//    var body: some View {
//        ZStack {
//            Circle()
//                .frame(width: 200, height: 200)
//                .foregroundColor(color)
//            Text("\(number)")
//                .foregroundColor(.white)
//                .font(.system(size: 70, weight: .bold))
//        }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
            CharacterSelectView(userName: "Test")
        }
    }
}
