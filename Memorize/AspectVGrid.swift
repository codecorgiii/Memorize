//
//  AspectVGrid.swift
//  Memorize
//
//  Created by Hans Allendorfer on 12/20/23.
//

import SwiftUI

struct AspectVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    var aspectRatio: CGFloat = 1
    @ViewBuilder var content: (Item) -> ItemView
    
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(cardCount: items.count, gridItemContainerSize: geometry.size, atAspectRatio: aspectRatio)
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(items) { item in
                    content(item)                .aspectRatio(aspectRatio, contentMode: .fit)

                }
            }
        }
    }
    
    func gridItemWidthThatFits(
        cardCount: Int,
        gridItemContainerSize: CGSize,
        atAspectRatio aspectRatio: CGFloat
    ) -> CGFloat {
        let cardCount = CGFloat(cardCount)
        var columnCount = CGFloat(1.0)
        
        repeat {
            let cardWidth = gridItemContainerSize.width / columnCount
            let cardHeight = cardWidth / aspectRatio
            let rowCount = (cardCount / columnCount).rounded(.up)
            if rowCount * cardHeight < gridItemContainerSize.height {
                return cardWidth.rounded(.down)
            }
            columnCount += 1
        } while columnCount < cardCount
        
        return gridItemContainerSize.width / cardCount
    }
}
