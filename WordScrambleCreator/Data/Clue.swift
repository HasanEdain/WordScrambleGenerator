//
//  Clue.swift
//  WordScrambleCreator
//
//  Created by Hasan Edain on 9/30/24.
//

import Foundation

struct Clue: Codable, Identifiable {
    let id: UUID
    let word: String
    let scrambled: String
    let index: Int

    init(word: String, index: Int, id: UUID = UUID()) {
        self.word = word.uppercased()
        self.scrambled = WordHelper.scramble(word: word).uppercased()
        self.index = index
        self.id = id
    }

    func offsetFrom(middle:CGFloat) -> CGFloat {
        let difference = middle - CGFloat(index)

        return difference
    }
}
