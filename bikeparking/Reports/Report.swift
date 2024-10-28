//
//  Report.swift
//  bikeparking
//
//  Created by Simone Tesini on 28/10/24.
//

import SwiftData

enum ReportType: Codable {
    case theft
    case found
}

enum ReportLocation: Codable {
    case coords(_: Coordinates, address: String)
    case spot(_: BarebonesParkingSpot)
}

@Model
final class Report {
    var location: ReportLocation
    var type: ReportType
    
    // TODO: photo of the bike...
    
    // Identification information
    var fullName: String?
    var desc: String?
    var remarks: String?
    
    // Contact information
    var phoneNumber: String?
    var email: String?
    var facebook: String?
    var instagram: String?
    
    init(location: ReportLocation, type: ReportType, fullName: String? = nil, desc: String? = nil, remarks: String? = nil, phoneNumber: String? = nil, email: String? = nil, facebook: String? = nil, instagram: String? = nil) {
        self.location = location
        self.type = type
        self.fullName = fullName
        self.desc = desc
        self.remarks = remarks
        self.phoneNumber = phoneNumber
        self.email = email
        self.facebook = facebook
        self.instagram = instagram
    }
    
    func title() -> String {
        switch self.location {
        case .coords(let coords, let address):
            return "in " + address
        case .spot(let spot):
            return "al parcheggio " + spot.title
        }
    }
}

extension Report {
    static var sampleData = [
        Report(
            location: .spot(ParkingSpot.sampleData[0].bareBones()),
            type: .found,
            fullName: "mesini tisone",
            desc: "ho trovato questa bici mentre andavo a tubre... vero casino",
            remarks: "presenta uno sticker",
            phoneNumber: "+39 123 456 7890",
            email: "chiefkeefbestmoments@hotmail.com",
            facebook: "mesini tisone",
            instagram: "@dragodelnord"
        ),
        Report(
            location: .spot(ParkingSpot.sampleData[1].bareBones()),
            type: .theft,
            fullName: "herris",
            desc: "stavo battendo uno a suon di proof e nel frattempo mi hanno rubato la bici... disastro...",
            remarks: "presentava 5 sticker",
            phoneNumber: "+39 123 456 7890",
            email: "theproof@zestymail.com"
        ),
        Report(
            location: .coords(Coordinates(latitude:39.223, longitude:23.44442), address: "via bressanone 22"),
            type: .found,
            fullName: "tûbarao rainbow6siege",
            desc: "fra non stavo facendo nulla come il solito, quando ho deciso di andare al despar e ho trovato questa...",
            remarks: "nessuno",
            phoneNumber: "+39 123 456 7890",
            email: "icantstopplayingrainbowsixsiegeandbeinganeet@yahoo.com"
        )
    ]
}
