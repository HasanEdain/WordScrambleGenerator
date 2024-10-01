//
//  WordHelper.swift
//  WordScrambleCreator
//
//  Created by Hasan Edain on 9/30/24.
//

import Foundation

struct WordHelper {

    static func middleLetter(word: String) -> CGFloat {
        let count = word.count

        let floatCount = CGFloat(count)
        let floatMiddle = floatCount / 2.0

        return floatMiddle
    }

    static func scramble(word: String) -> String {
        let letters = Array(word)

        let scrambledRange = letters.shuffled()
        let scrambledWord = String(scrambledRange)
        
        return scrambledWord
    }

    static func cluesFor(word: String, range: ClosedRange<Int>) -> [Clue] {
        let letters: [Character] = Array(word)
        var clues: [Clue] = []

        var letterIndex: Int = 0

        letters.forEach { letter in
            let length = Int.random(in: range)
            if let word = WordHelper.word(length: length, containing: letter) {
                let character: Character = Character(extendedGraphemeClusterLiteral: letters[letterIndex])
                let index = index(letter: character, in: word)
                let clue = Clue(word: word, index: index)

                letterIndex = letterIndex + 1
                clues.append(clue)
            }
        }

        return clues
    }


    static func index(letter: Character, in word: String) -> Int {
        let letters = Array(word)
        var index: Int = 0
        var count: Int = 0
        var found: Bool = false

        letters.forEach { character in
            if found == false {
                if character == letter {
                    index = count
                    found = true
                }
                count = count + 1
            }
        }

        return index
    }

    static func word(length: Int, containing: Character) -> String? {
        var words = CommonWords.wordList(wordLength: length)
        let characterSet = CharacterSet(charactersIn:String(containing))
        var result: String = ""

        var found: Bool = false
        while found != true && words.count > 0 {
            let index = Int.random(in: 0..<words.count)
            let word = words[index]
            let range = word.rangeOfCharacter(from: characterSet)
            if range != nil {
                result = word
                found = true
            } else {
                words.remove(at: index)
            }
        }

        return result
    }
}
