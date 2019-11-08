//
//  ContentView.swift
//  Switcharoo { Paul Hudson }
//
//  Created by Dmitry Novosyolov on 28/10/2019.
//  Copyright © 2019 Dmitry Novosyolov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var activeLetters = [String](repeating: "Blank", count: 4)
    @State private var tray = [String](repeating: "Blank", count: 10)
    @State private var buttonFrames = [CGRect](repeating: .zero, count: 4)
    @State private var timeRemaining = 100
    @State private var score = 0
    let allowedWords = Bundle.main.words(from: "words.txt")
    let startWords = Bundle.main.words(from: "start.txt")
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                GameNumber(text: "Time", value: self.timeRemaining)
                Image("Switcharoo")
                GameNumber(text: "Score", value: self.score)
            }.padding()
            
            Spacer()
            
            HStack {
                ForEach(0..<4) { number in
                    Letter(text: self.activeLetters[number], index: number)
                        .allowsHitTesting(false)
                        .overlay( GeometryReader { geoProxy in
                            Color.clear
                                .onAppear {
                                    self.buttonFrames[number] = geoProxy.frame(in: .global)
                            }
                            }
                    )
                }
            }
            
            ResetButton {
                self.resetLetters(deductPoints: true)
            }
            
            Spacer()
            
            HStack {
                ForEach(0..<10) { number in
                    Letter(text: self.tray[number], index: number, onChanged: self.letterMoved, onEnded: self.letterDropped)
                }
            }.padding()
            
            ShuffleTray {
                self.tray.shuffle()
            }
        }
        .frame(width: 1024, height: 768)
        .background(Image("Background"))
        .onAppear (perform: startGame)
        .allowsHitTesting(timeRemaining > 0)
        .onReceive(timer) { value in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
            }
        }
    }
    
    func resetLetters(deductPoints: Bool) {
        let newWord = startWords.randomElement() ?? "CAPE"
        activeLetters = newWord.map(String.init)
        tray = (1...10).map { _ in self.randomLetter()}
        deductPoints ? score -= 10 : nil
    }
    
    func startGame() {
        resetLetters(deductPoints: false)
    }
    
    func randomLetter() -> String {
        String("AAAAABBCCDDDDDEEEEEEEFGGHIIIIJKLMMMMMNNNNNNNOPPPPPQRRRRRSSSSSSTTTTTTUVWWXYZ".randomElement() ?? "E")
    }
    
    func letterMoved(location: CGPoint, letter: String) -> DragState {
        if let match = buttonFrames.firstIndex(where: { $0.contains(location)}) {
            if activeLetters[match] == letter { return .bad }
            var testLetters = activeLetters
            testLetters[match] = letter
            let testWord = String(testLetters.joined())
            return allowedWords.contains(testWord) ? .good : .bad
        } else {
            return .unknown
        }
    }
    
    func letterDropped(location: CGPoint, trayIndex: Int, letter: String) {
        if let match = buttonFrames.firstIndex(where: { $0.contains(location)}) {
            activeLetters[match] = letter
            
            tray.remove(at: trayIndex)
            tray.append(randomLetter())
            
            timeRemaining += 2
            score += 1
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
