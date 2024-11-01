//
//  TipsView.swift
//  bikeparking
//
//  Created by Simone Tesini on 02/11/24.
//

import SwiftUI

struct TipsView: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(Tip.sampleData) { tip in
                    TipListItem(tip: tip)
                }
            }
                
            .navigationTitle("Consigli")
        }
    }
}

#Preview {
    TipsView()
}
