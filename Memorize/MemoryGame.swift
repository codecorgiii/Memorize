//
//  MemoryGame.swift
//  Memorize
//
//  Model for Memorize game
//
//  Created by Hans Allendorfer on 12/17/23.
//

import Foundation // includes arrays, ints, bools, dictionaries

struct MemoryGame<CardContent> { // the wider the scope the generic ("don't care") is placed, the more it'll apply to the sub-structs
    // access control for setter only
    private(set) var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        self.cards = []
        for pairIndex in 0..<max(2,numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func chooseCard(_ card: Card) {
        
    }
    
    // any function that can modify the model has to be marked "mutating"
    // someone calling this function is going to cause a copy-on-write
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    // Namespaced as MemoryGame.Card
    struct Card {
        var isFaceUp = true // explicit mutability
        var isMatched = false
        let content: CardContent
    }
}
