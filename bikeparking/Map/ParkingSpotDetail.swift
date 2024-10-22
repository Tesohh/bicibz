//
//  ParkingSpotDetail.swift
//  bikeparking
//
//  Created by Simone Tesini on 22/10/24.
//

import SwiftUI

struct ParkingSpotDetail: View {
    @Environment(\.dismiss) private var dismiss
    var spot: ParkingSpot
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(spot.title).font(.title).fontWeight(.bold)
                HStack {
                    Text("coordinate:")
                    Text("\(spot.coords.latitude), \(spot.coords.longitude)")
                }
                Spacer()
            }
            Spacer()
        }.padding(.all)
    }
}

#Preview {
    ParkingSpotDetail(
        spot: ParkingSpot.sampleData[0]
    )
}
