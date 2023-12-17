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
    var cards: [Card]
    func chooseCard(card: Card) {
        
    }
    
    // Namespaced as MemoryGame.Card
    struct Card {
        var isFaceUp: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
