//
//  ParkingSpot.swift
//  bikeparking
//
//  Created by Simone Tesini on 19/10/24.
//

import Foundation
import SwiftData
import MapKit

@Model
final class ParkingSpot {
    @Attribute(.unique) var coords: CLLocationCoordinate2D
    var title: String
    var ratings: [ParkingSpotRating]
    
    init(coords: CLLocationCoordinate2D, title: String? = nil, ratings: [ParkingSpotRating]) {
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

