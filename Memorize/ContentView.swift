//
//  ContentView.swift
//  Memorize
//
//  Created by Hans Allendorfer on 12/8/23.
//

import SwiftUI



struct ContentView: View {
    var body: some View {
        HStack {
            CardView(isFaceUp: true)
            CardView()
            CardView()
            CardView()
        }
        .foregroundColor(.orange)
        .padding()
    }
}

struct CardView: View {
    var isFaceUp: Bool = false // vars in structs require a value, ex) default value
    
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 12).foregroundColor(.white)
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(lineWidth: 2) // behaves like a View, behaves like a Shape
                Text("🐧").font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 12)
            }
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
