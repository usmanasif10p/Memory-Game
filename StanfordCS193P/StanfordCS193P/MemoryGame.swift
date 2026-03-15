//
//  MemorizeGame.swift
//  StanfordCS193P
//
//  Created by Usman Asif on 27/02/2026.
//

import Foundation


// MARK: THE MODEL
struct MemoryGame<CardContent> where CardContent: Equatable { // rather using <> type with Card struct, the initializer should pass CardContent type
    private(set) var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            cards.indices.filter { index in cards[index].isFaceUp }.only
        }
        set {
            cards.indices.forEach { cards[$0].isFaceUp = (newValue == $0) }
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = chosenIndex
                }
                cards[chosenIndex].isFaceUp = true
             }
        }
    }
        
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        
        // when things confirms Equatable protocol, Swift will do itself so explicitly writing is unnecessory
//        static func == (lhs: MemoryGame<CardContent>.Card, rhs: MemoryGame<CardContent>.Card) -> Bool {
//            <#code#>
//        }
//        static func == (lhs: Card, rhs: Card) -> Bool {
//            return lhs.isFaceUp == rhs.isFaceUp && lhs.isMatched == rhs.isMatched && lhs.content == rhs.content
//        }

        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
        
//        var id: ObjectIdentifier
        var id: String
        
        var debugDescription: String {
            return "Card(id: \(id), content: \(content), isFaceUp: \(isFaceUp), isMatched: \(isMatched))"
        }

    }
}

extension Array {
    var only: Element? {
        return count == 1 ? first : nil
    }
}
