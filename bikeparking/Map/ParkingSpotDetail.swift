//
//  ParkingSpotDetail.swift
//  bikeparking
//
//  Created by Simone Tesini on 22/10/24.
//

import SwiftUI
import SwiftData
import MapKit

struct ParkingSpotDetail: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var lookaroundScene: MKLookAroundScene?
    
    var spot: ParkingSpot
    
    @State private var showingSheet: Bool = false
    
    var body: some View {
        ScrollView {
            HStack {
                VStack(alignment: .leading) {
                    Text(spot.title).font(.title).fontWeight(.bold)
                    HStack {
                        Text("coordinate:")
                        Text("\(spot.coords.latitude), \(spot.coords.longitude)")
                    }.foregroundStyle(.secondary)
                    
                    if spot.thefts().count > 0 {
                        HStack {
                            Text("furti qua:")
                            Text("\(spot.thefts().count)")
                        }.foregroundStyle(.red)
                    }
                        
                    
                    VStack {
                        HStack() {
                            VStack(alignment: .leading) {
                                Text("SICUREZZA")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                StaticStarRatingView(rating: spot.averageSecurityScore())
                            }
                            
                            Divider().padding(.horizontal)
                            
                            VStack(alignment: .leading) {
                                Text("COMODITÀ")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                StaticStarRatingView(rating: spot.averageConvenienceScore())
                            }
                        }.frame(maxWidth: .infinity)
                        
                        Button(action: {
                            showingSheet.toggle()
                        }) {
                            Image(systemName: "plus")
                            Text("valuta anche tu")
                        }
                    }
                    LookAroundPreview(initialScene: lookaroundScene)
                        .frame(height: 160)
                        .cornerRadius(10)
                        .padding(.vertical)
                }
                Spacer()
            }
        }
        .padding(.all)
        .task(id: spot) {
            print("averages: ", spot.averageSecurityScore(), spot.averageConvenienceScore())
            await fetchScene()
        }
        .background(Color(.systemBackground))
        .sheet(isPresented: $showingSheet) {
            NewRatingView(rating: NewParkingSpotRating(), spot: spot, isSpotVariable: false) { rating, spot in
                spot.ratings.append(rating)
                spot.ratings = spot.ratings
                try! modelContext.save()
            }
                .presentationBackgroundInteraction(.automatic)
                .presentationBackground(.regularMaterial)
        }
    }
    
    private func fetchScene() async {
        let request = MKLookAroundSceneRequest(coordinate: spot.coords.toAppleCoordinates())
        self.lookaroundScene = try! await request.scene
    }
}

#Preview {
    ParkingSpotDetail(
        spot: ParkingSpot.sampleData[0]
    )
}
