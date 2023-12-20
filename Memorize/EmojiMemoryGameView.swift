//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Hans Allendorfer on 12/8/23.
//

import SwiftUI



struct EmojiMemoryGameView: View {
    // if something changed in viewModel, redraw me
    // observed objects always need to be passed into, because they need to be marked as the truth (state)
   @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
            Spacer()
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }.padding()
    }
    
    var cards: some View {
        // implicit return, this is not a view builder, just a normal function with one line of code, don't need an explicit return (same with computed properties)
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in // index is an argument to the closure
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12) // type inference, locals in @ViewBuilder
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2) // behaves like a View, behaves like a Shape
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }.opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isMatched ? 0 : 1)
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
