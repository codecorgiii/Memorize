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
    private(set) var currentTheme = Theme.cat

    private static func createMemoryGame(theme: Theme = Theme.cat) -> MemoryGame<String> {

        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfPairs) {_ in theme.emojis.randomElement() ?? theme.emojis.first!}
    }
    
    // @Published - if this var  changes, it'll tell "something changed" to the UI
    @Published private var model = createMemoryGame()
    
    var cards: [MemoryGame<String>.Card] {
        return model.cards
    }
    
    var score: Int {
        return model.score
    }
    
    var cardColor: Color {
        switch currentTheme.color {
        case "gray": .gray
        case "brown": .brown
        case "orange": .orange
        case "yellow": .yellow
        case "blue": .blue
        default: .black
        }
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.chooseCard(card)
    }
    
    func newGame() {
        let newTheme = Theme.allCases.filter({$0.self != currentTheme }).randomElement() ?? Theme.bird
        model = EmojiMemoryGame.createMemoryGame(theme: newTheme)
        currentTheme = newTheme
    }
}
