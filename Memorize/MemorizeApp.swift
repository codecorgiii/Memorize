//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Hans Allendorfer on 12/8/23.
//

import SwiftUI

@main
struct MemorizeApp: App {
    // somewhere the state needs to be declared, we do it at the top level here
    @StateObject var game = EmojiMemoryGame()

    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
