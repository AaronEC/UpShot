//
//  ContentView.swift
//  UpShot
//
//  Created by Aaron Cardwell on 07/03/2022.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack{
                
                HomePageView()
                    .navigationTitle("Home")
                
                NavigationLink(destination: BlueTwoView(color: .blue), label: {Text("Start Match")
                        .bold()
                        .frame(width: 280, height: 50)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
                
                NavigationLink(destination: BlueTwoView(color: .red), label: {Text("Options")
                        .bold()
                        .frame(width: 280, height: 50)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
                
                Spacer()
            }
        }
        .accentColor(Color(.label))
    }
}

struct BlueTwoView: View {
    
    var color: Color
    
    var body: some View {
        VStack{
            TempView(color: color, number: 2)
                .navigationTitle("Match Page")
                .offset(y: -60)
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
        HomeView()
            
    }
}
