//
//  NewRatingView.swift
//  bikeparking
//
//  Created by Simone Tesini on 24/10/24.
//

import SwiftUI

struct NewRatingView: View {
    @State var rating: ParkingSpotRating
    @State var spot: ParkingSpot? = nil
    var title: String = "Nuova valutazione"
    var body: some View {
        NavigationStack {
            Form {
                Section("Parcheggio") {
                    
                NavigationLink(spot == nil ? "Seleziona un parcheggio..." : "\(spot!.title)") {
                    ParkingSpotPickerView(spots: ParkingSpot.sampleData) { spot in
                        self.spot = spot
                    }
                }
                    
                }
                Section("Sicurezza") {
                    Toggle("Recintata?", isOn: $rating.fenced)
                    Toggle("Zona ad alto traffico?", isOn: $rating.crowded)
                    Toggle("Sorvegliata?", isOn: $rating.surveilled)
                    HStack {
                        Text("Zona poco sospetta")
                        Spacer()
                        StarRatingView(rating: $rating.lowCrimeRate, starSize: 20, starColor: .orange)
                    }
                }
                
                Section("Comodità") {
                    HStack {
                        Text("Qualità del parcheggio")
                        Spacer()
                        StarRatingView(rating: $rating.quality, starSize: 20, starColor: .orange)
                    }
                    HStack {
                        Text("Capacità")
                        Spacer()
                        StarRatingView(rating: $rating.capacity, starSize: 20, starColor: .orange)
                    }
                    HStack {
                        Text("Comodità della zona")
                        Spacer()
                        StarRatingView(rating: $rating.locationQuality, starSize: 20, starColor: .orange)
                    }
                }
                Button("Invia") {
                    print("basta si manda")
                }
            }.navigationTitle("Nuova valutazione")
        }
    }
}

#Preview {
    var rating = NewParkingSpotRating()
    NewRatingView(rating: rating)
}
