//
//  MemoryGame.swift
//  Memorize
//
//  Model for Memorize game
//
//  Created by Hans Allendorfer on 12/17/23.
//

import Foundation // includes arrays, ints, bools, dictionaries

struct MemoryGame<CardContent> where CardContent : Equatable { // the wider the scope the generic ("don't care") is placed, the more it'll apply to the sub-structs
    // access control for setter only
    private(set) var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        self.cards = []
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: "\(pairIndex+1)a"))
            cards.append(Card(content: content, id: "\(pairIndex+1)b"))
        }
        cards.shuffle()
    }
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            let faceUpCardIndices = cards.indices.filter({ cards[$0].isFaceUp })
            return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
        }
        set {
            cards.indices.forEach({ cards[$0].isFaceUp = ($0 == newValue) })
        }
    }
    
    mutating func chooseCard(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
            if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
                if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                    if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                        cards[chosenIndex].isMatched = true
                        cards[potentialMatchIndex].isMatched = true
                    }
                } else {
                    indexOfTheOneAndOnlyFaceUpCard = nil
                }
                cards[chosenIndex].isFaceUp.toggle()
            }
        }
    }
    
    // any function that can modify the model has to be marked "mutating"
    // someone calling this function is going to cause a copy-on-write
    mutating func shuffle() {
        cards.shuffle()
    }
    
    // Namespaced as MemoryGame.Card
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
        
        var id: String
        var debugDescription: String {
            "\(id) - \(content), \(isMatched ? "matched" : "unmatched") \(isFaceUp ? ", face up" : "")"
        }
    }
}
