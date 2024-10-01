//
//  Puzzle.swift
//  WordScrambleCreator
//
//  Created by Hasan Edain on 9/30/24.
//

import Foundation

class Puzzle: ObservableObject {
    @Published var clues: [Clue]
    @Published var scrambledClues: [Clue]
    @Published var superClue: Clue

    init(clues: [Clue], superClue: Clue) {
        self.clues = clues
        self.scrambledClues = clues.shuffled()
        self.superClue = superClue
    }

    func scrambledWords() -> [String] {
        var words: [String] = []
        scrambledClues.forEach { clue in
            words.append(clue.scrambled)
        }

        return words
    }

    func middle() -> CGFloat {
        let wordMid = WordHelper.middleLetter(word: superClue.word)

        return wordMid
    }

    func randomize(superLength: Int, clueLengthRange: ClosedRange<Int>) {
        guard let tempPuzzle = Puzzle.randomPuzzle(superLength: superLength, clueLengthRange: clueLengthRange) else {
            return
        }
        self.clues = tempPuzzle.clues
        self.scrambledClues = tempPuzzle.scrambledClues
        self.superClue = tempPuzzle.superClue
    }

    static func randomPuzzle(superLength: Int, clueLengthRange:ClosedRange<Int>) -> Puzzle? {
        guard let superWord = CommonWords.wordsOf(length: superLength).randomElement() else {
            return nil
        }
        let clues = WordHelper.cluesFor(word: superWord, range: clueLengthRange)
        let superClue = Clue(word: superWord, index: -1)
        let puzzle = Puzzle(clues: clues, superClue: superClue)

        return puzzle
    }

    static var helloPuzzle: Puzzle {
        let supeC = Clue(word: "HELLO", index: -1)
        let clues = [
            Clue(word: "ALOHA", index: 3),
            Clue(word: "ELL", index: 0),
            Clue(word: "ELBOW", index: 1),
            Clue(word: "KNEEL", index: 4),
            Clue(word: "ALONE", index: 2)
        ]

        return Puzzle(clues: clues, superClue: supeC)
    }
}
