//
//  ContentView.swift
//  Memorize
//
//  Created by Hans Allendorfer on 12/8/23.
//

import SwiftUI



struct ContentView: View {
    let emojis: [String] = ["🐧","🐥","🐓","🐧", "🦚", "🦃", "🪿", "🦤", "🦩"]
    @State var cardCount = 4
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var cards: some View {
        // implicit return, this is not a view builder, just a normal function with one line of code, don't need an explicit return (same with computed properties)
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120, maximum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in // index is an argument to the closure
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    // internal vs external parameter names, by = label that callers use, offset = label that we use in the function
    // symbol is both the internal and external parameter name
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.fill.badge.minus")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: +1, symbol: "rectangle.stack.fill.badge.plus")
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true // type inference, vars in structs require a value, ex) default value
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12) // type inference, locals in @ViewBuilder
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2) // behaves like a View, behaves like a Shape
                Text(content).font(.largeTitle)
            }.opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            print("Tapped")
            //isFaceUp = !isFaceUp // Views (self) including their vars are immutable, need to add @State
            // isFaceUp = !isFaceUp
            isFaceUp.toggle()
        }
    }
}


// creating instances of structs: examples) Image, Text
// named parameters: example) systemName
// parameter defaults: other arguments that you could specify, but have a default value so you don't have to put it. example) VStack(alignment: .center) by default
struct ContentView2: View {
    // computed property
    var body: some View {
        VStack(alignment: .leading) { // embedded function, function is passed as an argument to VStack
            // @ViewBuilder turns the List of Image, Text into a TupleView (Tuple can be more than 2 elements)
            Image(systemName: "globe")
                .imageScale(.large) // function call (View modifier, can be called on any function that behaves like a View)
            Text("Hello, world!")
                .padding()
        }
        .font(.largeTitle) // passed to vstack content!!
        .foregroundColor(.red) // scoping of view modifiers matters
    }
}

#Preview {
    ContentView()
}
