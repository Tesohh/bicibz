//
//  ParkingSpot.swift
//  bikeparking
//
//  Created by Simone Tesini on 19/10/24.
//

import Foundation
import SwiftData
import MapKit

let STAR = UInt8(51)

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
    
    func toAppleCoordinates() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

@Model
final class ParkingSpot {
    var coords: Coordinates
    var title: String
    var ratings: [ParkingSpotRating]
    
    init(coords: Coordinates, title: String? = nil, ratings: [ParkingSpotRating]) {
        self.coords = coords
        self.title = title ?? "Parcheggio"
        self.ratings = ratings
    }
    
    func averageSecurityScore() -> UInt8 {
        let totalSecurityScore = self.ratings.reduce(0) { sum, rating in sum + Int(rating.securityScore()) }
        return UInt8(mapValue(Float(totalSecurityScore), fromRange: 0...Float(Int.max), toRange: 0...255))
    }
    
    func averageConvenienceScore() -> UInt8 {
        let totalConvenienceScore = self.ratings.reduce(0) { sum, rating in sum + Int(rating.convenienceScore()) }
        return UInt8(mapValue(Float(totalConvenienceScore), fromRange: 0...Float(Int.max), toRange: 0...255))
    }
    
    func averageTotalScore() -> UInt8 {
        let totalScore = self.ratings.reduce(0) { sum, rating in sum + Int(rating.totalScore()) }
        return UInt8(mapValue(Float(totalScore), fromRange: 0...Float(Int.max), toRange: 0...255))
    }
}

extension ParkingSpot {
    static var sampleData: [ParkingSpot] = [
        ParkingSpot(coords: Coordinates(latitude: 46.494372, longitude: 11.332784), title: "vicino al Cissy", ratings: [
            ParkingSpotRating(fenced: true, crowded: false, surveilled: false, lowCrimeRate: STAR*2, quality: STAR*5, capacity: STAR*3, locationQuality: STAR*5),
            ParkingSpotRating(fenced: true, crowded: false, surveilled: true, lowCrimeRate: STAR*4, quality: STAR*4, capacity: STAR*1, locationQuality: STAR*2),
            ParkingSpotRating(fenced: true, crowded: false, surveilled: false, lowCrimeRate: STAR*3, quality: STAR*4, capacity: STAR*2, locationQuality: STAR*2)
        ]),
        ParkingSpot(coords: Coordinates(latitude: 46.495255, longitude: 11.332159), title: "vicino alla banca", ratings: [
            ParkingSpotRating(fenced: false, crowded: false, surveilled: true, lowCrimeRate: STAR*5, quality: STAR*2, capacity: STAR*3, locationQuality: STAR*5),
            ParkingSpotRating(fenced: false, crowded: false, surveilled: true, lowCrimeRate: STAR*4, quality: STAR*1, capacity: STAR*1, locationQuality: STAR*5),
            ParkingSpotRating(fenced: true, crowded: false, surveilled: false, lowCrimeRate: STAR*4, quality: STAR*3, capacity: STAR*2, locationQuality: STAR*4)
        ])
    ]
}
