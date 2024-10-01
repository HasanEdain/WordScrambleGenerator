//
//  GenerateView.swift
//  WordScrambleCreator
//
//  Created by Hasan Edain on 9/30/24.
//

import SwiftUI

struct GenerateView: View {
    @State var puzzle: Puzzle

    @State var clueWordLengthString: String = "5"
    @State var subRangeMinString: String = "4"
    @State var subRangeMaxString: String = "8"

    @State var saveCountString: String = "0"
    @State var filename: String = "Puzzle"
    var size: CGFloat = 64.0

    var body: some View {
        VStack {
            PuzzleView(size: size)
            HStack {
                Form {
                    TextField(text: $clueWordLengthString) {
                        Label("Super Clue Length", systemImage: "richtext.page.fill")
                    }
                    TextField(text: $subRangeMinString) {
                        Label("min clue length", systemImage: "richtext.page.fill")
                    }
                    TextField(text: $subRangeMaxString) {
                        Label("max clue length", systemImage: "richtext.page.fill")
                    }
                    Button("Generate") {
                        gen()
                    }
                }.frame(width: 300)
                Form {
                    TextField(text: $filename) {
                        Label("Filename", systemImage: "richtext.page.fill")
                    }
                    TextField(text: $saveCountString) {
                        Label("Save Count", systemImage: "richtext.page.fill")
                    }
                    Button("Save") {
                        save()
                    }
                }.frame(width: 300)

            }
        }.padding()
    }

    func gen() {
        guard let length = Int(clueWordLengthString) else {
            return
        }
        guard let min = Int(subRangeMinString) else {
            return
        }
        guard let max = Int(subRangeMaxString) else {
            return
        }
        puzzle.randomize(superLength: length, clueLengthRange: min...max)
    }

    @MainActor func save() {
        let rendererSolved = ImageRenderer(content: SolvedPuzzleView(size: size).environmentObject(puzzle))
        let redererPuzzle = ImageRenderer(content: PuzzleView(size: size).environmentObject(puzzle))

        guard let saveCount = Int(self.saveCountString) else {
            return
        }

        let homeURL = FileManager.default.homeDirectoryForCurrentUser
        let solvedUrl = homeURL.appending(path: "\(filename)_\(saveCount)_solved.pdf")
        print("\(solvedUrl.absoluteString)")
        let unsolvedUrl = homeURL.appending(path: "\(filename)_\(saveCount)_puzzle.pdf")

        rendererSolved.render { size, renderInContext in
            var box = CGRect(
                origin: .zero,
                size: .init(width: 932, height: 900)
            )

            guard let context = CGContext(solvedUrl as CFURL, mediaBox: &box, nil) else {
                return
            }

            context.beginPDFPage(nil)
            renderInContext(context)
            context.endPage()
            context.closePDF()
        }

        redererPuzzle.render { size, renderInContext in
            var box = CGRect(
                origin: .zero,
                size: .init(width: 1300, height: 900)
            )

            guard let context = CGContext(unsolvedUrl as CFURL, mediaBox: &box, nil) else {
                return
            }

            context.beginPDFPage(nil)
            renderInContext(context)
            context.endPage()
            context.closePDF()
        }

        self.saveCountString = String(saveCount + 1)
    }
}

#Preview {
let puzzle = Puzzle.randomPuzzle(superLength: 8, clueLengthRange: 3...8) ?? Puzzle.helloPuzzle

    GenerateView(puzzle: puzzle)
        .environmentObject(puzzle)
        .frame(width: 1200)
}
