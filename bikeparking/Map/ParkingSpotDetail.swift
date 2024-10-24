//
//  ParkingSpotDetail.swift
//  bikeparking
//
//  Created by Simone Tesini on 22/10/24.
//

import SwiftUI
import MapKit

struct ParkingSpotDetail: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var lookaroundScene: MKLookAroundScene?
    
    var spot: ParkingSpot
    var body: some View {
        ScrollView {
            HStack {
                VStack(alignment: .leading) {
                    Text(spot.title).font(.title).fontWeight(.bold)
                    HStack {
                        Text("coordinate:")
                        Text("\(spot.coords.latitude), \(spot.coords.longitude)")
                    }.foregroundStyle(.secondary)
                    
                    VStack {
                        HStack() {
                            VStack(alignment: .leading) {
                                Text("SICUREZZA")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                StarRatingView(rating: uint8ToStars(spot.averageSecurityScore()))
                            }
                            
                            Divider()
                            
                            VStack(alignment: .leading) {
                                Text("COMODITÀ")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                StarRatingView(rating: uint8ToStars(spot.averageConvenienceScore()))
                            }
                        }.frame(maxWidth: .infinity)
                        
                        Button(action: {}) {
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
