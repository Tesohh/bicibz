//
//  TipDetailView.swift
//  bikeparking
//
//  Created by Simone Tesini on 02/11/24.
//

import SwiftUI

struct TipDetailView: View {
    var tip: Tip
    var body: some View {
        NavigationStack {
            if let image = tip.getAppleImage() {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350)
                    .cornerRadius(10)
                    .padding(.top, -60)
            }
            Text(tip.desc).padding()
                .navigationTitle(tip.title).navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    TipDetailView(tip: Tip.sampleData[0])
}
