//
//  MatchView.swift
//  UpShot
//
//  Created by Aaron Cardwell on 14/01/2022.
//

import SwiftUI


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
    
    @StateObject private var viewModel = MatchViewModel()
    
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
                        ForEach(Array(viewModel.oppValue), id: \.self) { character in
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
                        Text(String(viewModel.oppTotal))
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
                        ForEach(Array(viewModel.value), id: \.self) { character in
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
                        Text(String(viewModel.total))
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
                if viewModel.complete {
                    NavigationLink(destination: ResultsView(result: viewModel.getResult(), score: viewModel.getScore(), username: userName), label: {Text("Results Page")
                            .bold()
                            .frame(width: 280, height: 50)
                            .background(Color("AccentColour"))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                    })
                } else if viewModel.shoot {
                    Text("Enter your score:")
                        .foregroundColor(.white)
                } else {
                    VStack {
                        Text(charNames[Int(charID) ?? 0] + " is shooting...")
                            .opacity(viewModel.visible ? 0 : 1)
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
                                    self.viewModel.didTap(button: item, charID: charID)
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
                        .disabled(!viewModel.visible)
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
