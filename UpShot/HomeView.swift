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

enum scoreButtons: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case ten = "10"
    case miss = "M"
    
    var buttonColour: Color {
        switch self {
        case .ten, .nine:
            return .yellow
        case .eight, .seven:
            return .red
        case .six, .five:
            return .blue
        case .four, .three:
            return .black
        case .two, .one:
            return .white
        case .miss:
            return Color(.lightGray)
        }
    }
    
    var numberColour: Color {
        switch self {
        case .ten, .nine, .two, .one:
            return .black
        default:
            return .white
        }
    }
    
}

struct MatchView: View {
    
    @State var value = "------"
    @State var total = 0
    
    @State var oppValue = "------"
    @State var oppTotal = 0
    
    @State var message = ""
    @State private var visible = true
    @State private var shoot = true
    @State private var complete = false
    
    var userName: String
    var charNames:[String]
    var charID: String
    var buttons: [[scoreButtons]] = [
        [.ten, .nine, .eight],
        [.seven, .six, .five],
        [.four, .three, .two],
        [.miss, .one]
    ]

    var body: some View {

        VStack{
            
            Text(charNames[Int(charID) ?? 0] + " Vs " + userName)
                .font(.system(size: 32, weight: .bold))
                .multilineTextAlignment(.center)
            
            Spacer()
            
            // Score Display
            HStack {
                
                Spacer()
                
                // Opponent
                VStack {
                    
                    Spacer()
                    
                    VStack {
                        ForEach(Array(oppValue), id: \.self) { character in
                            if character == "x" {
                                Text("10")
                                    .bold()
                                    .font(.system(size: 28))
                                    .foregroundColor(Color("MainColour"))
                            } else {
                                Text(String(character))
                                    .bold()
                                    .font(.system(size: 28))
                                    .foregroundColor(Color("MainColour"))
                            }
                        }
                    }
                    .background(
                        Color("AltColour")
                            .frame(width: 100)
                            .opacity(0.75)
                            .cornerRadius(10)
                            .padding(.vertical, -10)
                    )
                    
                    Spacer()

                    VStack {
                        Text("Total:")
                    Text(String(oppTotal))
                        .bold()
                        .font(.system(size: 48))
                    }
                    .background(
                        Color("AltColour")
                            .frame(width: 100)
                            .opacity(0.75)
                            .cornerRadius(10)
                            .padding(.top, -10)
                    )
                    
                    Spacer()

                }
                .background(
                    Image("Character" + charID)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 387, height: 200)
                        .padding(.leading, -150)
                )
                .padding(.leading, 30)
                
                Spacer()
                
                // Player
                VStack {
                    
                    Spacer()
                    
                    VStack {
                        ForEach(Array(value), id: \.self) { character in
                            if character == "x" {
                                Text("10")
                                    .bold()
                                    .font(.system(size: 28))
                                    .foregroundColor(Color("MainColour"))
                            } else {
                                Text(String(character))
                                    .bold()
                                    .font(.system(size: 28))
                                    .foregroundColor(Color("MainColour"))
                            }
                        }
                    }
                    .background(
                        Color("AltColour")
                            .frame(width: 100)
                            .opacity(0.75)
                            .cornerRadius(10)
                            .padding(.vertical, -10)
                    )
                    
                    Spacer()

                    VStack {
                        Text("Total:")
                    Text(String(total))
                        .bold()
                        .font(.system(size: 48))
                    }
                    .background(
                        Color("AltColour")
                            .frame(width: 100)
                            .opacity(0.75)
                            .cornerRadius(10)
                            .padding(.top, -10)
                    )
                    
                    Spacer()

                }
                .background(
                    Image("Target")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 87, height: 150)
                        .padding(.trailing, -150)
                )
                .padding(.trailing, 30)
                
                Spacer()
                
            }

            HStack {
                if complete {
                    NavigationLink(destination: ResultsView(result: getResult(), score: getScore(), username: userName), label: {Text("Results Page")
                            .bold()
                            .frame(width: 280, height: 50)
                            .background(Color("AccentColour"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                    })
                } else if shoot {
                    Text("Enter your score:")
                        .foregroundColor(.white)
                } else {
                    VStack {
                        Text(charNames[Int(charID) ?? 0] + " is shooting...")
                            .opacity(visible ? 0 : 1)
                            .foregroundColor(.white)
                    }
                }
            }
            .background(
                Color(.black)
                    .padding(.horizontal, -2000)
                    .padding(.vertical, -5)
            )
            
                        
            Spacer()
            
            

            // Input Buttons
                VStack {
                    ForEach(buttons, id: \.self) { row in
                        HStack {
                            ForEach(row, id: \.self) {item in
                                Button(action: {
                                    self.didTap(button: item)
                                }, label: {
                                    Text(item.rawValue)
                                        .font(.system(size: 28))
                                        .frame(
                                            width: self.buttonWidth(item: item),
                                            height: self.buttonHeight()
                                        )
                                        .background(item.buttonColour)
                                        .foregroundColor(item.numberColour)
                                        .overlay(
                                            RoundedRectangle(
                                                cornerRadius: 15
                                            )
                                                .stroke(Color(.black), lineWidth: 4)
                                            )
                                })
                            }
                            .cornerRadius(15)
                        }
                        .padding(.horizontal, 20)
                        .disabled(!visible)
                    }
                }
                .padding(.top, 10)
                .background(
                    Color("AltColour")
                        .opacity(0.75)
                        .cornerRadius(10)
                        .padding([.leading, .trailing, .bottom], -50)
                        .padding(.top, -5)
                )
        }
    
    }
    
    private func pulsateText() {
            withAnimation(Animation.easeInOut.repeatCount(14, autoreverses: false)) {
                visible.toggle()
            }
        }
    
    func getResult() -> String {
        
        var result = ""
        
        if total == oppTotal {
            result = "Draw"
        } else if total > oppTotal {
            result = "Win"
        } else {
            result = "Lose"
        }
        
        return result
    }
    
    func getScore() -> String {
               
        return String(oppTotal) + " - " + String(total)
    }
    
    func oppScore() {
                
        let randomInt = Int.random(in: 0..<11)
        
        if randomInt == 10 {
            self.oppValue.removeFirst()
            self.oppValue = self.oppValue + "x"
            self.oppTotal += 10
        } else if randomInt == 0 {
            self.oppValue.removeFirst()
            self.oppValue = self.oppValue + "M"
            self.oppTotal += randomInt
        } else {
            self.oppValue.removeFirst()
            self.oppValue = "\(self.oppValue)\(randomInt)"
            self.oppTotal += randomInt
        }
        
        if self.value.first != "-" {
            complete.toggle()
            return
        }

    }
    
    func didTap(button: scoreButtons) {
        
        shoot = false
        
        class TryThis {
            func getSomethingLater(_ number: Double) async -> String {
                // sleep for 3 seconds, then return
                Thread.sleep(forTimeInterval: 3)
                return String(format: ">>>%8.2f<<<", number)
            }
        }

        let tryThis = TryThis()
        
        let number = button.rawValue
        
        if self.oppValue.first != "-" {
            return
        }
        
        if number == "10" {
            self.value.removeFirst()
            self.value = self.value + "x"
            self.total += 10
        } else {
            self.value.removeFirst()
            self.value = "\(self.value)\(number)"
            self.total += Int(number) ?? 0
        }
        
        pulsateText()
        
        Task {
            await tryThis.getSomethingLater(1)
            oppScore()
            visible.toggle()
            shoot = true
        }
    }
    
    func buttonWidth(item: scoreButtons) -> CGFloat {
        if item.rawValue == "M" {
            return (UIScreen.main.bounds.width) / 2 + 8
        }
        return (UIScreen.main.bounds.width) / 4
    }
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width) / 9
    }
}


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

struct OptionView: View {

    var color: Color

    var body: some View {
        VStack{
            Text("Options Page")
        }
    }
}


struct HomePageView: View {
    var body: some View {

        Image("cover")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(.top, 20)
            .scaledToFit()

        Spacer()
    }
}

struct TestView: View {

    @State private var selectedTab = "1"

    var body: some View {

        VStack{
        TabView(selection: $selectedTab) {
            Text("Tab 1")
                .onTapGesture {
                    selectedTab = "2"
                }
                .tag("2")
            Text("Tab 2")
                .onTapGesture {
                    selectedTab = "3"
                }
                .tag("3")
            Text("Tab 3")
                .onTapGesture {
                    selectedTab = "4"
                }
                .tag("4")
        }
        .tabViewStyle(PageTabViewStyle())
        Text(selectedTab)

        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            ResultsView(result: "Draw", score: "23 - 45", username: "Aaron")
//            HomeView()
//            CharacterSelectView(userName: "Aaron")
            MatchView(userName: "Aaron", charNames: ["Joey","Sarah", "Beth"], charID: "0")
        }
    }
}
