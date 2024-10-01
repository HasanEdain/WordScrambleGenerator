    //
    //  PuzzleView.swift
    //  WordScrambleCreator
    //
    //  Created by Hasan Edain on 9/30/24.
    //

import SwiftUI

struct PuzzleView: View {
    @EnvironmentObject var puzzle: Puzzle
    let size: CGFloat

    var body: some View {
        VStack (spacing: 4){
            HStack {
                    ScrambledWordsView(size: size)
                        .frame(width: 300)
                        .offset(CGSize(width: -250, height: 0.0))
                    offsetClues
                }
            ScrambledClueView(clue: puzzle.superClue, size: size).padding()
        }.frame(width: 1200)
            .padding()
    }

    @ViewBuilder var offsetClues: some View {
        VStack (spacing: 4.0){
            ForEach(puzzle.scrambledClues) { clue in
                ScrambledClueView(clue: clue, size: size)
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
    PuzzleView(size: 64.0)
        .frame(width: 1200)
        .environmentObject(Puzzle.randomPuzzle(superLength: 5, clueLengthRange: 3...6) ?? Puzzle.helloPuzzle)
}
