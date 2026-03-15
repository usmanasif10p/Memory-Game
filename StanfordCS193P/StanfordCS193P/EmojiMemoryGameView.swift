//
//  EmojiMemoryGameView.swift
//  StanfordCS193P
//
//  Created by Usman Asif on 26/02/2026.
//

import SwiftUI
import Combine

struct EmojiMemoryGameView: View { // View should be stateless, declared and reactive
    
    /*
     @ObservedObject VS @StateObject in terms of lifetime and the scope of it
     */
    
    //@ObservedObject var viewModel: EmojiMemoryGame = EmojiMemoryGame() // serious NO, shouldn't be init here
    //@StateObject var viewModel: EmojiMemoryGame = EmojiMemoryGame() //
    @ObservedObject var viewModel: EmojiMemoryGame // Reactive-UI @ObservedObject if there something changed redraw views
    
//    let emojis = ["👻", "🎃", "🧟‍♂️", "🧟‍♀️", "👹", "👻", "🎃", "🧟‍♂️", "🧟‍♀️"] // move to the model
//    @State var cardCount = 4
    
    // var body: Text { // this is also correct body as it only valid for View of type Text
    //    Text("Hello World!")
    // }
    
    var body: some View { // computed property it computes every time it calls and also body is not a struct its a protocol
        
        // VStack() { this one is also correct
        // }
        
        // VStack(content: { but actually its like this, the default parameter
        // })
        
        // @ViewBuilder | tuple view
        
        VStack {
            ScrollView {
                cards
                    .animation(.default, value: viewModel.cards)
            }
//            Spacer()
//            cardCountAdjusters
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .padding()
    }
    
    private var cards: some View {
        // LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 77), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
    }
    
    /*
    private var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
    }
    
    private func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button {
            cardCount += offset
        } label: {
            Image(systemName: symbol)
                .font(.largeTitle)
        }
        .disabled( cardCount + offset < 1 || cardCount + offset > emojis.count )
    }
    
    private var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
//        Button {
//            if cardCount < 2 { return }
//            cardCount -= 1
//        } label: {
//            Image(systemName: "rectangle.stack.badge.minus.fill")
//                .font(.largeTitle)
//        }
    }
    
    private var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.badge.plus.fill")
//        Button {
//            if cardCount >= emojis.count { return }
//            cardCount += 1
//        } label: {
//            Image(systemName: "rectangle.stack.badge.plus.fill")
//                .font(.largeTitle)
//        }
    }
     */
    
}

struct CardView: View {
//    let context: String
//    @State var isFaceUp = true // @State allows immutable property to become mutable
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) { // overwriting free-init so that when use CardView(... rather than CardView(card: ...
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity( card.isFaceUp ? 1 : 0 )
            base.fill()
                .opacity( card.isFaceUp ? 0 : 1 )
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
        .foregroundStyle(.orange) // view modifiers can apply from outside toward inside views
        //        .onTapGesture {
        //            isFaceUp = !isFaceUp
        //        }
    }
}

#Preview {
    EmojiMemoryGameView(viewModel: EmojiMemoryGame())
}
