//
//  AppView.swift
//  bikeparking
//
//  Created by Simone Tesini on 28/10/24.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            MapView().tabItem { Label("Mappa", systemImage: "map") }
            ReportsView().tabItem { Label("Segnalazioni", systemImage: "bubble.left.and.exclamationmark.bubble.right.fill") }
        }
    }
}

#Preview {
    AppView()
}
