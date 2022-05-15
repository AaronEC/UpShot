//
//  MatchViewModel.swift
//  UpShot
//
//  Created by Aaron Cardwell on 14/05/2022.
//

import SwiftUI

final class MatchViewModel: ObservableObject {
    
    @Published var value = "------"
    @Published var total = 0
    
    @Published var oppValue = "------"
    @Published var oppTotal = 0
    
    @Published var visible = true
    @Published var shoot = true
    @Published var complete = false
    
    
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
    
    func oppScore(charID: String) {
                
        var randomInt = Int.random(in: 0..<11)
        
        if charID != "0" {
            
            let difficulty = (Int(charID) ?? 0) * 4

            for _ in 0...difficulty {
                if randomInt != 9 && randomInt != 10 {
                    randomInt = Int.random(in: 0..<11)
                }
            }
            
        }
        
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
    
    private func pulsateText() {
            withAnimation(Animation.easeInOut.repeatCount(14, autoreverses: false)) {
                visible.toggle()
            }
        }
    
    func didTap(button: scoreButtons, charID: String) {
        
        shoot = false
        
        class TryThis {
            func getSomethingLater(_ number: Double) async -> String {
                // sleep for 3 seconds, then return (to simulate taking a shot)
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
            oppScore(charID: charID)
            visible.toggle()
            shoot = true
        }
    }
}
