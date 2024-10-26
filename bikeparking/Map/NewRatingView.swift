//
//  NewRatingView.swift
//  bikeparking
//
//  Created by Simone Tesini on 24/10/24.
//

import SwiftUI

struct NewRatingView: View {
    @Environment(\.dismiss) private var dismiss
    @State var rating: ParkingSpotRating
    @State var spot: ParkingSpot? = nil
    var title: String = "Nuova valutazione"
    
    var isSpotVariable = true
    
    var callback: (ParkingSpotRating, ParkingSpot) -> Void = {_, _ in}
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Parcheggio") {
                    if isSpotVariable {
                        NavigationLink(spot == nil ? "Seleziona un parcheggio..." : "\(spot!.title)") {
                            ParkingSpotPickerView(spots: ParkingSpot.sampleData) { spot in
                                self.spot = spot
                            }
                        }
                    } else {
                        Text(spot == nil ? "Parcheggio non selezionabile" : "\(spot!.title)")
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
                    guard let spot else {return}
                    callback(rating, spot)
                    dismiss()
                }
            }.navigationTitle("Nuova valutazione")
        }
    }
}

#Preview {
    var rating = NewParkingSpotRating()
    NewRatingView(rating: rating)
}
