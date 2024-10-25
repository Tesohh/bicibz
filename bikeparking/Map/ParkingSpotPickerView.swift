//
//  ParkingSpotPickerView.swift
//  bikeparking
//
//  Created by Simone Tesini on 25/10/24.
//

import SwiftUI

struct ParkingSpotPickerView: View {
    let spots: [ParkingSpot]
    @State private var search: String = ""
    @State private var matchingSpots: [ParkingSpot] = []
    
    @Environment(\.dismiss) private var dismiss
    
    var onSpotSelected: (ParkingSpot) -> Void = {_ in}
    
    var body: some View {
        NavigationStack {
            List(matchingSpots) { spot in
                HStack {
                    Image(systemName: "parkingsign.circle.fill")
                        .foregroundStyle(.secondary)
                    Button(spot.title) {
                        onSpotSelected(spot)
                        dismiss()
                    }.foregroundStyle(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.secondary)
                }
                
            }
            .onChange(of: search) {
                self.updateMatching(search)
            }
            .onAppear() {
                self.updateMatching(search)
            }
            
            .navigationTitle("Seleziona un parcheggio")
            .searchable(text: $search)
            .textInputAutocapitalization(.never)
        }
    }
    
    private func updateMatching(_ query: String) {
        if query.isEmpty {
            self.matchingSpots = spots
        } else {
            self.matchingSpots = spots.filter { spot in
                spot.title
                    .lowercased()
                    .contains(query)
            }
        }
    }
}

#Preview {
    ParkingSpotPickerView(spots: ParkingSpot.sampleData)
}
