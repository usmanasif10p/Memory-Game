//
//  EmojiMemoryGame.swift
//  StanfordCS193P
//
//  Created by Usman Asif on 27/02/2026.
//

import SwiftUI
import Combine

//func createCardContent(for index: Int) -> String {
//    ["👻", "🎃", "🧟‍♂️", "🧟‍♀️", "👹", "👻", "🎃", "🧟‍♂️", "🧟‍♀️"][index]
//}

class EmojiMemoryGame: ObservableObject { // Reactive-UI ObservableObject
//    var objectWillChange: ObservableObjectPublisher
    
    private static let emojis = ["👻", "🎃", "🧟‍♂️", "🧟‍♀️", "👹", "👻", "🎃", "🧟‍♂️", "🧟‍♀️"] // static means make it global but namespace inside EmojiMemoryGame.emojis
        
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "!?"
            }
        }
    }
    
    @Published private var model = createMemoryGame() // model should be private otherwise view can access model like viewModel.model which shouldn't be the case
                                                      // Reactive-UI @Published so that whenever it changes notifies

    var cards: [MemoryGame<String>.Card] {
        return self.model.cards
    }
    
    func shuffle() {
        self.model.shuffle()
//        objectWillChange.send()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        self.model.choose(card)
    }
    
}
