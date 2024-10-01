//
//  WordScrambleCreatorApp.swift
//  WordScrambleCreator
//
//  Created by Hasan Edain on 9/30/24.
//

import SwiftUI

@main
struct WordScrambleCreatorApp: App {
    @StateObject var puzzle: Puzzle = Puzzle.helloPuzzle
    
    var body: some Scene {
        WindowGroup {
            GenerateView(puzzle: puzzle, size: 64.0)
                .padding()
                .environmentObject(puzzle)
        }
    }
}
