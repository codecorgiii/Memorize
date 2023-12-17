//
//  ContentView.swift
//  Memorize
//
//  Created by Hans Allendorfer on 12/8/23.
//

import SwiftUI



struct ContentView: View {
    @State var emojis = Theme.bird.getEmojis().shuffled()
    @State var cardColor = Theme.bird.getCardColor()
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            ThemePicker(availableThemes: [Theme.bird, Theme.flower, Theme.ocean]) { theme in
                self.emojis = theme.getEmojis().shuffled()
                self.cardColor = theme.getCardColor()
            }
        }
        .padding()
    }
    
    var cards: some View {
        // implicit return, this is not a view builder, just a normal function with one line of code, don't need an explicit return (same with computed properties)
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60, maximum: 120))]) {
            ForEach(0..<emojis.count, id: \.self) { index in // index is an argument to the closure
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(cardColor)
    }
}

enum Theme {
    case bird, ocean, flower
    
    func getImageSymbol() -> String {
        switch self {
        case .bird:
            "bird.fill"
        case .flower:
            "globe"
        case .ocean:
            "water.waves"
        }
    }
    
    func getLabel() -> String {
        switch self {
        case .bird:
            "Birds"
        case .ocean:
            "Ocean"
        case .flower:
            "Flower"
        }
    }
    
    func getEmojis() -> [String] {
        switch self {
        case .bird:
            ["🐧","🐧","🐥","🐥","🐓","🐓","🦚","🦚","🦃", "🪿", "🦤", "🦩"]
        case .ocean:
            ["🐟","🐟","🦀","🦀","🐙","🐙","🐬","🐬","🐳","🦑","🐡"]
        case .flower:
            ["🌹","🌹","🌸","🌸","💐","💐","🌺","🌺","🌻","🪷","🪻"]
        }
    }
    
    func getCardColor() -> Color {
        switch self {
        case .bird:
            Color.black
        case .ocean:
            Color.blue
        case .flower:
            Color.pink
        }
    }
}

struct ThemePicker: View {
    let availableThemes: [Theme]
    let onThemeSelected: ((Theme) -> Void)
    
    var body: some View {
        HStack(alignment: VerticalAlignment.lastTextBaseline) {
            ForEach(0..<availableThemes.count, id: \.self) { index in
                Button(action: {
                    onThemeSelected(availableThemes[index])
                }, label: {
                    VStack {
                        Image(systemName: availableThemes[index].getImageSymbol())
                        Text(availableThemes[index].getLabel())
                    }.frame(maxWidth: .infinity)
                })
                .font(.callout)
                .imageScale(.large)
            }
        }
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false // type inference, vars in structs require a value, ex) default value
    
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
