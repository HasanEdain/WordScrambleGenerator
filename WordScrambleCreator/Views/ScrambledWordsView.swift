//
//  ScrambledWordsView.swift
//  WordScrambleCreator
//
//  Created by Hasan Edain on 9/30/24.
//

import SwiftUI

struct ScrambledWordsView: View {
    @EnvironmentObject var puzzle: Puzzle
    
    let size: CGFloat

    var body: some View {
        VStack (spacing: 4.0) {
            ForEach(puzzle.scrambledWords(), id: \.self) { word in
                Text("\(word)")
                    .font(.system(size: size - 18))
                    .fontWeight(.black)
                    .frame(height: size)
            }
        }
    }
}

#Preview {
    ScrambledWordsView(size: 64.0)
        .environmentObject(Puzzle.helloPuzzle)
}
