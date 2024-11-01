//
//  ReportListItem.swift
//  bikeparking
//
//  Created by Simone Tesini on 28/10/24.
//

import SwiftUI

struct TipListItem: View {
    var tip: Tip
    var body: some View {
        NavigationLink(destination: TipDetailView(tip: tip)) {
            VStack(alignment: .leading) {
                if let image = tip.getAppleImage() {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 100)
                        .cornerRadius(2)
                }
                
                Text(tip.title).frame(maxWidth: .infinity, alignment: .leading)
                
                
            }
        }
    }
}

#Preview {
    NavigationStack {
        List {
            TipListItem(tip: Tip.sampleData[0])
        }
        .navigationTitle("Consigli")
    }
}
