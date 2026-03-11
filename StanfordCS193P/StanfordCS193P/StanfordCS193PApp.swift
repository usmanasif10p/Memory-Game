//
//  StanfordCS193PApp.swift
//  StanfordCS193P
//
//  Created by Usman Asif on 26/02/2026.
//

import SwiftUI

@main
struct StanfordCS193PApp: App {
    @StateObject private var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
