//
//  ScrambledClueView.swift
//  WordScrambleCreator
//
//  Created by Hasan Edain on 9/30/24.
//

import SwiftUI

struct ScrambledClueView: View {
    let clue: Clue
    let size: CGFloat

    var body: some View {
        clueView
    }

    @ViewBuilder var clueView: some View {
        let letters = Array(clue.scrambled)
        let max: Int = letters.count
        HStack (spacing: 4){
            ForEach(0..<max, id: \.self) { index in
                if index == clue.index {
                    LetterView(letter: " ", isClue: true, size: size)
                } else {
                    LetterView(letter: " ", isClue: false, size: size)
                }
            }
        }
    }
}

#Preview {
    let clue1 = Clue(word: "Hello", index: 3)

    ScrambledClueView(clue: clue1, size: 64.0)
}
