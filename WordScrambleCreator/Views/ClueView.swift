//
//  ClueView.swift
//  WordScrambleCreator
//
//  Created by Hasan Edain on 9/30/24.
//

import SwiftUI

struct ClueView: View {
    let clue: Clue
    let size: CGFloat

    var body: some View {
        clueView
    }

    @ViewBuilder var clueView: some View {
        let letters = Array(clue.word)
        let max: Int = letters.count
        HStack (spacing: 4){
            ForEach(0..<max, id: \.self) { index in
                if index == clue.index {
                    LetterView(letter: letters[index], isClue: true, size: size)
                } else {
                    LetterView(letter: letters[index], isClue: false, size: size)
                }
            }
        }
    }
}

#Preview {
    let clue1 = Clue(word: "Hello", index: 3)

    ClueView(clue: clue1, size: 64)
}
