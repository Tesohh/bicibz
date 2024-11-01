//
//  AppView.swift
//  bikeparking
//
//  Created by Simone Tesini on 28/10/24.
//

import SwiftUI

struct AppView: View {
//    @Environment(\.modelContext) private var modelContext
    var body: some View {
        TabView {
            MapView()
                .tabItem { Label("Mappa", systemImage: "map") }
            ReportsView()
                .tabItem { Label("Segnalazioni", systemImage: "bubble.left.and.exclamationmark.bubble.right.fill") }
            TipsView()
                .tabItem { Label("Consigli", systemImage: "lightbulb") }
        }
    }
}

#Preview {
    AppView()
}
