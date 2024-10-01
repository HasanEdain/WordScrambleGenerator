//
//  PuzzleView.swift
//  WordScrambleCreator
//
//  Created by Hasan Edain on 9/30/24.
//

import SwiftUI

struct SolvedPuzzleView: View {
    @EnvironmentObject var puzzle: Puzzle
    let size: CGFloat

    var body: some View {
        VStack (spacing: 4){
            offsetClues
            ClueView(clue: puzzle.superClue, size: size).padding()
        }
        .frame(width: 900)
        .padding()

    }

    @ViewBuilder var offsetClues: some View {
        VStack (spacing: 4.0){
            ForEach(puzzle.clues) { clue in
                ClueView(clue: clue, size: size)
                    .offset(CGSize(
                        width: -clueOffset(clue: clue),
                        height: 0.0
                    )
                    )
            }
        }
    }

    func clueOffset(clue: Clue) -> CGFloat {
        let index = clue.index
        let wordLength = clue.word.count
        let midWordIndex = CGFloat(wordLength)/2.0

        let difference = CGFloat(index) - midWordIndex

        let baseSize = CGFloat(  size + 4 )

        let offsetAmount = CGFloat( difference ) * baseSize

        return offsetAmount
    }
}

#Preview {
    SolvedPuzzleView(size: 64.0)
        .environmentObject(Puzzle.randomPuzzle(superLength: 8, clueLengthRange: 3...8) ?? Puzzle.helloPuzzle)
}
