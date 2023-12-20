//
//  Theme.swift
//  Memorize
//
//  Created by Hans Allendorfer on 12/20/23.
//

import Foundation

enum Theme: CaseIterable {
    case bird, dog, cat, fruit, sports
    
    var name: String {
        switch self {
        case .bird:
            "Bird"
        case .dog:
            "Dog"
        case .cat:
            "Cat"
        case .fruit: "Fruit"
        case .sports: "Sports"
        }
    }
    
    var emojis: [String] {
        switch self {
        case .bird:
            ["🕊️", "🦅", "🦆", "🦜", "🐧", "🦉", "🐤", "🐥", "🦢", "🐓", "🦩", "🦚", "🦃"]
        case .dog:
            ["🐶","🐕","🦮","🐩","🐕‍🦺","🐾","🦴","🌭"]
        case .cat:
            ["🐱","🐈","🐈‍⬛","😹","😻","🙀","😸","😽"]
        case .fruit: ["🍒","🍓","🍇","🍎","🍉","🍑","🍊","🍋","🍍"]
        case .sports: ["⚽️","🏀","🏈","🎾"]
        }
    }
    
    var numberOfPairs: Int {
        switch self {
        case .bird: 10
        case .dog: 6
        case .cat: 8
        case .fruit: 7
        case .sports: 8
        }
    }
    
    var color: String {
        switch self {
        case .bird: "gray"
        case .dog: "brown"
        case .cat: "orange"
        case .fruit: "yellow"
        case .sports: "blue"
        }
    }
}
