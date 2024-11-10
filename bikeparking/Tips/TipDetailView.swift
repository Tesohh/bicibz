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
                ScrollView {
                    if let image = tip.getAppleImage() {
                        GeometryReader { geometry in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: min(geometry.size.width - 40, 350))
                                .cornerRadius(10)
                                .padding(.top, 20) // Adjust as needed for spacing
                                .padding(.horizontal, 20)
                        }
                        .frame(height: 200) // Set an estimated frame height to avoid scroll view collapse
                    }
                    Text(tip.desc)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                }
                .navigationTitle(tip.title)
                .navigationBarTitleDisplayMode(.inline)
            }
        }
}

#Preview {
    TipDetailView(tip: Tip.sampleData[1])
}
