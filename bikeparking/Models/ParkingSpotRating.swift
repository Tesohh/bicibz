//
//  ParkingSpotRating.swift
//  bikeparking
//
//  Created by Simone Tesini on 19/10/24.
//

func mapValue(_ value: Float, fromRange: ClosedRange<Float>, toRange: ClosedRange<Float>) -> Float {
    let clampedValue = min(max(value, fromRange.lowerBound), fromRange.upperBound)
    let proportion = (clampedValue - fromRange.lowerBound) / (fromRange.upperBound - fromRange.lowerBound)
    return toRange.lowerBound + (proportion * (toRange.upperBound - toRange.lowerBound))
}

func uint8ToStars(_ value: UInt8) -> Double {
    return Double(mapValue(Float(value), fromRange: 0...255, toRange: 0...5))
}


struct ParkingSpotRating: Codable {
    // security
    let fenced: Bool
    let crowded: Bool
    let surveilled: Bool
    let lowCrimeRate: UInt8
    
    // convenience
    let quality: UInt8
    let capacity: UInt8
    let locationQuality: UInt8
    
    // 51 roughly equals 1 star in uint8
    
    func securityScore() -> UInt8 {
        var score: UInt8 = 0 // 0 -> 255
        // 32  from fenced
        // 32  from crowded
        // 64  from surveilled
        // 128 from crimerate
        if self.fenced     { score += 32 }
        if self.crowded    { score += 32 }
        if self.surveilled { score += 64 }
        score += UInt8(mapValue(Float(self.lowCrimeRate), fromRange: 0...255, toRange: 0...128))
        
        return score
    }
    
    func convenienceScore() -> UInt8 {
        var score: UInt8 = 0 // 0 -> 255
        // 85  from quality
        // 85  from capacity
        // 85  from locationQuality
        score += UInt8(mapValue(Float(self.quality), fromRange: 0...255, toRange: 0...85))
        score += UInt8(mapValue(Float(self.capacity), fromRange: 0...255, toRange: 0...85))
        score += UInt8(mapValue(Float(self.locationQuality), fromRange: 0...255, toRange: 0...85))
        return score
    }
    
    func totalScore() -> UInt8 {
        var score: UInt8 = 0 // 0 -> 255
        // 192 from security
        // 63  from convenience
        score += UInt8(mapValue(Float(self.securityScore()),    fromRange: 0...255, toRange: 0...192))
        score += UInt8(mapValue(Float(self.convenienceScore()), fromRange: 0...255, toRange: 0...63))
        return score
    }
}
