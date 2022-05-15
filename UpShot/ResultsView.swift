//
//  ResultsView.swift
//  UpShot
//
//  Created by Aaron Cardwell on 14/01/2022.
//

import SwiftUI

struct ResultsView: View {
    
    var result: String
    var score: String
    var username: String
    
    var messages = [
        
        ["Win": "Congratulations ",
        "Lose": "Unlucky ",
        "Draw": "So Close "],
        
        ["Win": "You Won!",
        "Lose": "Keep trying!",
        "Draw": "You Drew"],
        
        ]
    
    var code = ["Win": 0,
                "Lose": 1,
                "Draw": 2]

    var body: some View {
        VStack {
            
            Text(messages[0][result] ?? "Draw" + username)
                .font(.system(size: 32, weight: .bold))
                .multilineTextAlignment(.center)
            
            Text(messages[1][result] ?? "Draw")
                .font(.system(size: 64, weight: .bold))
                .multilineTextAlignment(.center)
            
            Image("result" + String(code[result] ?? 2))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, 20)
                .scaledToFit()
            
            Text("Your Score Was:")
                .font(.system(size: 44, weight: .bold))
                .multilineTextAlignment(.center)
            
            Text(score)
                .font(.system(size: 32, weight: .bold))
                .multilineTextAlignment(.center)
            
            NavigationLink(destination: CharacterSelectView(userName: username), label: {Text("New Match")
                    .bold()
                    .frame(width: 280, height: 50)
                    .background(Color("AccentColour"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })

            NavigationLink(destination: HomeView(), label: {Text("Home Screen")
                    .bold()
                    .frame(width: 280, height: 50)
                    .background(Color("MainColour"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            })
            
        }
        .padding()
    }
}
