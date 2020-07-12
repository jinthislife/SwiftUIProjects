//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Jin Lee on 12/7/20.
//  Copyright © 2020 Jin Lee. All rights reserved.
//

import SwiftUI

enum Move: String {
    case Rock
    case Paper
    case Scissors
}

enum GameResult: String {
    case Won
    case Lost
    case None
}

struct MoveButtonDesign: View {
    var move: Move
    var body: some View {
        Text(move.rawValue)
            .padding(20)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
    }
}

struct ContentView: View {
    
    let moves: [Move] = [.Rock, .Paper, .Scissors]
    @State private var chosenMove = Int.random(in: 0 ... 2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var currentRound = 1
    @State private var roundResult: GameResult = .None
    @State private var showingResult = false
    @State private var endGame = false

    
    var body: some View {
        VStack(spacing: 12) {
            Text("\(currentRound) / 10")
            Text("Score: \(score)")
                .font(.headline)
            Text("\(moves[chosenMove].rawValue)")
            Text(shouldWin ? "You should win": "You should lose")
            
            ForEach(moves, id: \.self) { move in
                Button(action: {
                    self.compete(with: move)
                }) {
                    MoveButtonDesign(move: move)
                }
                .disabled(self.endGame)
            }
            
            Button(action: {
                self.resetGame()
            }) {
                Text("Reset")
            }

        }
        .alert(isPresented: $showingResult) {
            Alert(title: Text("You \(roundResult.rawValue)"), message: Text("Your score is \(score)"), dismissButton: .default(Text("Continue ")) {
                self.startGame()
                })
        }
        
    }
    
    func resetGame() {
        currentRound = 0
        score = 0
        endGame = false
        chosenMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
    }
    
    func startGame() {
        
        if currentRound == 10 {
            endGame = true
            return
        }
        
        chosenMove = Int.random(in: 0...2)
        shouldWin = Bool.random()
        currentRound += 1
    }
    
    func compete(with move: Move) {
        
        let opponentMove = moves[chosenMove]
        
        switch opponentMove {
        case .Rock:
            if shouldWin == true && move == .Paper ||
                shouldWin == false && move == .Scissors  {
                winGame()
                return
            }
        case .Paper:
            if shouldWin == true && move == .Scissors ||
                shouldWin == false && move == .Rock {
                winGame()
                return
            }
        case .Scissors:
            if shouldWin == true && move == .Rock ||
                shouldWin == false && move == .Paper {
                winGame()
                return
            }
        }
        
        loseGame()
        
    }
    
    private func winGame() {
        showingResult = true
        roundResult = .Won
        score += 1
    }
    
    private func loseGame() {
        showingResult = true
        roundResult = .Lost
        score -= 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
