//
//  MatchViewModel.swift
//  UpShot
//
//  Created by Aaron Cardwell on 14/01/2022.
//

import SwiftUI

final class MatchViewModel: ObservableObject {
    
    // Player score variables
    @Published var value = "------"
    @Published var total = 0
    //Opponent score variables
    @Published var oppValue = "------"
    @Published var oppTotal = 0
    //Prompt control variables
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
    
    // Calculates the opponents next score with CharID as difficulty modifier.
    private func oppScore(charID: String) {
                
        var randomInt = Int.random(in: 0..<11)
        
        if charID != "0" {
            
            let difficulty = (Int(charID) ?? 0) * 4

            // More chance of good score for higher difficulty.
            for _ in 0...difficulty {
                if randomInt != 9 && randomInt != 10 {
                    randomInt = Int.random(in: 0..<11)
                }
            }
            
        }
        
        // This handles formatting of double digit scores & misses.
        // and calculates total score.
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

        // Enable match complete status after last arrow.
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
        
        // Is it the end of the match?
        if self.oppValue.first != "-" {
            return
        }
        
        shoot = false
        
        let number = button.rawValue
        
        // More handling of double digit numbers
        // For player this time.
        if number == "10" {
            self.value.removeFirst()
            self.value = self.value + "x"
            self.total += 10
        } else {
            self.value.removeFirst()
            self.value = "\(self.value)\(number)"
            self.total += Int(number) ?? 0
        }
        
        // This causes a delay in the system by sleeping thread
        // to simulate that it takes some time for the AI to shoot.
        class Delay {
            func pause(_ number: Double) async {
                // sleep for 3 seconds, then return (to simulate taking a shot)
                Thread.sleep(forTimeInterval: number)
                return
            }
        }

        let custom_delay = Delay()
        pulsateText()
        
        Task {
            await custom_delay.pause(3)
            // Must be sent to mainthread as is UI update to avoid
            // thread collisions, race conditions, dead locks, etc.
            DispatchQueue.main.async{
                self.oppScore(charID: charID)
                self.visible.toggle()
                self.shoot = true
            }
        }
    }
}
