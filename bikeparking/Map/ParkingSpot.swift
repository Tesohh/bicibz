//
//  ParkingSpot.swift
//  bikeparking
//
//  Created by Simone Tesini on 19/10/24.
//

import Foundation
import SwiftData
import MapKit
import SwiftUI

let STAR = UInt8(51)

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
    
    func toAppleCoordinates() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

struct BarebonesParkingSpot: Codable {
    let coords: Coordinates
    let title: String
}

@Model
final class ParkingSpot {
    var coords: Coordinates
    var title: String
    var remarks: String?
    var ratings: [ParkingSpotRating]
    @Relationship(deleteRule: .nullify, inverse: \Report.spot) var reports: [Report]
    
    init(coords: Coordinates, title: String? = nil, remarks: String? = nil,  ratings: [ParkingSpotRating], reports: [Report] = []) {
        self.coords = coords
        self.title = title ?? "Parcheggio"
        self.ratings = ratings
        self.reports = reports
    }
    
    func averageSecurityScore() -> UInt8 {
        let totalSecurityScore = self.ratings.reduce(0) { sum, rating in sum + Int(rating.securityScore()) }
        return UInt8(totalSecurityScore / self.ratings.count)
    }
    
    func averageConvenienceScore() -> UInt8 {
        let totalConvenienceScore = self.ratings.reduce(0) { sum, rating in sum + Int(rating.convenienceScore()) }
        return UInt8(totalConvenienceScore / self.ratings.count)
    }
    
    func averageTotalScore() -> UInt8 {
        let totalScore = self.ratings.reduce(0) { sum, rating in sum + Int(rating.totalScore()) }
        return UInt8(totalScore / self.ratings.count)
    }
    
    func bareBones() -> BarebonesParkingSpot {
        return BarebonesParkingSpot(coords: self.coords, title: self.title)
    }
    
    func color() -> Color {
        let score = averageTotalScore()
        print(score)
        if score <= STAR*2 { return .red }
        else if score > STAR*2 && score <= STAR*3 {return .orange}
        else if score > STAR*3 && score <= STAR*5 {return .green}
        else { return .purple }
    }
    
    func thefts() -> [Report] {
        return reports.filter({ $0.type == .theft })
    }
}

extension ParkingSpot {
    static var sampleData: [ParkingSpot] = [
        ParkingSpot(coords: Coordinates(latitude: 46.495255, longitude: 11.332159), title: "vicino alla banca", ratings: [
            ParkingSpotRating(fenced: false, crowded: false, surveilled: true, lowCrimeRate: STAR*5, quality: STAR*2, capacity: STAR*3, locationQuality: STAR*5),
            ParkingSpotRating(fenced: false, crowded: false, surveilled: true, lowCrimeRate: STAR*4, quality: STAR*1, capacity: STAR*1, locationQuality: STAR*5),
            ParkingSpotRating(fenced: true, crowded: false, surveilled: false, lowCrimeRate: STAR*4, quality: STAR*3, capacity: STAR*2, locationQuality: STAR*4)
        ]),
        ParkingSpot(coords: Coordinates(latitude: 46.47929, longitude: 11.33222), title: "dentro al noitechpark", ratings: [
            ParkingSpotRating(fenced: true, crowded: true, surveilled: true, lowCrimeRate: STAR*5, quality: STAR*4, capacity: STAR*4, locationQuality: STAR*5),
        ]),
        ParkingSpot(coords: Coordinates(latitude: 46.48584, longitude: 11.33531), title: "prima del twenty", remarks: "consigliamo di parcheggiare qui solo per tempi molto brevi.", ratings: [
            ParkingSpotRating(fenced: false, crowded: true, surveilled: false, lowCrimeRate: STAR*1, quality: STAR*1, capacity: STAR*2, locationQuality: STAR*5),
        ]),
        ParkingSpot(coords: Coordinates(latitude: 46.49302, longitude: 11.34032), title: "davanti al despar di via roma", remarks: "ci sono altri parcheggi nei dintorni, sempre del despar", ratings: [
            ParkingSpotRating(fenced: false, crowded: true, surveilled: false, lowCrimeRate: STAR*3, quality: STAR*3, capacity: STAR*4, locationQuality: STAR*4),
        ]),
        ParkingSpot(coords: Coordinates(latitude: 46.496857523034734, longitude: 11.35304148578077), title: "vicino alla chiesa cappuccini", ratings: [
            ParkingSpotRating(fenced: false, crowded: false, surveilled: false, lowCrimeRate: STAR*1, quality: STAR*1, capacity: STAR*3, locationQuality: STAR*2),
        ]),
        ParkingSpot(coords: Coordinates(latitude: 46.497631168614134, longitude: 11.352304343849445), title: "vicino alla chiesa domenicani", ratings: [
            ParkingSpotRating(fenced: false, crowded: true, surveilled: false, lowCrimeRate: STAR*2, quality: STAR*5, capacity: STAR*4, locationQuality: STAR*4),
        ]),
        ParkingSpot(coords: Coordinates(latitude: 46.50551811701064, longitude: 11.346752873507857), title: "iis galilei e kunter", ratings: [
            ParkingSpotRating(fenced: true, crowded: true, surveilled: false, lowCrimeRate: STAR*4, quality: STAR*5, capacity: STAR*5, locationQuality: STAR*5),
        ]),
    ]
}
