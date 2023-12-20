//
//  EmojiMemoryGame.swift
//  Memorize
//
//  ViewModel for Memorize
//
//  Created by Hans Allendorfer on 12/17/23.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["🕊️", "🦅", "🦆", "🦜", "🐧", "🦉", "🐤", "🐥", "🦢", "🐓", "🦩", "🦚", "🦃"] // emojis is static but namespaced in the EmojiMemoryGame class. statics are initialized before init
    // property initializers run before self is available, static vars and funcs
    // order of property (member) initialization is undetermined - not in the order declared in the source code
        
    private static func createMemoryGame() -> MemoryGame<String> { // return types always need to be explicit in swift
        return MemoryGame<String>(numberOfPairsOfCards: 4) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        } // closure syntax, trailing closure syntax
    }
    
    // @Published - if this var  changes, it'll tell "something changed" to the UI
    @Published private var model = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.chooseCard(card)
    }
}
