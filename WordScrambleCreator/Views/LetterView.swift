//
//  LetterView.swift
//  WordScrambleCreator
//
//  Created by Hasan Edain on 9/30/24.
//

import SwiftUI

struct LetterView: View {
    let letter: Character
    let isClue: Bool
    let size: CGFloat
    let inset: CGFloat = 10.0

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundStyle(.white)
                .frame(width: size, height: size)
                .border(.black, width: 2.0)
            if isClue {
                Circle()
                    .stroke(.black, lineWidth: 2.0)
                    .frame(width: size - inset,height: size - inset)
            }
            Text("\(letter)")
                .foregroundStyle(.black)
                .font(.system(size: size - 18))
                .fontWeight(.black)
        }
    }
}

#Preview {
    let s = Character("S")
    let size: CGFloat = 64.0

    HStack {
        LetterView(letter: s, isClue: false, size: size)
            .padding()
        LetterView(letter: s, isClue: true, size: size)
            .padding()
    }

}
