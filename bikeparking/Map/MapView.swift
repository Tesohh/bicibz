//
//  MapView.swift
//  bikeparking
//
//  Created by Simone Tesini on 20/10/24.
//

import SwiftUI
import SwiftData
import MapKit

struct MapView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var parkingSpots: [ParkingSpot]
    @StateObject private var locationManager = LocationManager()
    
    @State var camera: MapCameraPosition = .userLocation(followsHeading: true, fallback: .automatic)
    
    @State var selectedSpot: ParkingSpot?
    
    var body: some View {
        Map(position: $camera, selection: $selectedSpot) {
            ForEach(parkingSpots) {spot in
                Group {
                    Marker(
                        spot.title,
                        systemImage: "bicycle",
                        coordinate: spot.coords.toAppleCoordinates()
                    )
                }
                .tag(spot)
                
            }
        }
        .sheet(item: $selectedSpot) { spot in
            ParkingSpotDetail(spot: spot)
                .presentationDetents([.medium])
        }
        .onAppear {
            locationManager.checkLocationAuthorization()
            
            guard parkingSpots.isEmpty else { return }
            for s in ParkingSpot.sampleData {
                modelContext.insert(s)
            }
        }
    }
}

#Preview {
    MapView(camera: .automatic)
        .modelContainer(for: ParkingSpot.self, inMemory: true)
}
