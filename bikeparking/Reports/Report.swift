//
//  Report.swift
//  bikeparking
//
//  Created by Simone Tesini on 28/10/24.
//

import SwiftData
import PhotosUI
import Foundation

enum ReportType: Codable {
    case theft
    case found
}

enum BarebonesReportLocation: Codable {
    case none
    case coords
    case spot
}

enum ReportLocation: Codable {
    case none
    case coords(_: Coordinates, address: String)
    case spot(_: BarebonesParkingSpot)
}

@Model
final class Report {
//    var location: ReportLocation
//    var barebonesLocation: BarebonesReportLocation
    var spot: ParkingSpot?
    var type: ReportType
    
    var creationDate: Date
    
    var imageData: Data?
    
    // Identification information
    var fullName: String?
    var desc: String?
    var remarks: String?
    
    // Contact information
    var phoneNumber: String?
    var email: String?
    var facebook: String?
    var instagram: String?
    
    init(spot: ParkingSpot?, type: ReportType, creationDate: Date?, imageData: Data?, fullName: String? = nil, desc: String? = nil, remarks: String? = nil, phoneNumber: String? = nil, email: String? = nil, facebook: String? = nil, instagram: String? = nil) {
        self.spot = spot
        self.type = type
        self.creationDate = creationDate ?? Date()
        self.imageData = imageData
        self.fullName = fullName
        self.desc = desc
        self.remarks = remarks
        self.phoneNumber = phoneNumber
        self.email = email
        self.facebook = facebook
        self.instagram = instagram
    }
    
    func title() -> String {
//        switch self.location {
//        case .none:
//            return "in [posizione sconosciuta]"
//        case .coords(_, let address):
//            return "in " + address
//        case .spot(let spot):
//            return "al parcheggio " + spot.title
//        }
        guard let title = spot?.title else {return "al [parcheggio sconosciuto]"}
        return "al parcheggio " + self.spot!.title
    }
    
    // Helper functions to convert UIImage to Data and vice versa
    func setAppleImage(_ image: UIImage) {
        self.imageData = image.jpegData(compressionQuality: 0.8) // You can adjust the compression quality
    }
    
    func getAppleImage() -> UIImage? {
        guard let imageData = imageData else { return nil }
        return UIImage(data: imageData)
    }
}

extension Report {
    static var sampleData = [
        Report(
            spot: ParkingSpot.sampleData[0],
            type: .found,
            creationDate: Date(timeIntervalSince1970: 1678718040),
            imageData: UIImage(named: "examplebike")?.jpegData(compressionQuality: 1.0),
            fullName: "mesini tisone",
            desc: "ho trovato questa bici mentre andavo a tubre... vero casino",
            remarks: "presenta uno sticker",
            phoneNumber: "+39 123 456 7890",
            email: "chiefkeefbestmoments@hotmail.com",
            facebook: "mesini tisone",
            instagram: "@dragodelnord"
        ),
        Report(
            spot: ParkingSpot.sampleData[1],
            type: .theft,
            creationDate: Date(timeIntervalSince1970: 1700404440),
            imageData: UIImage(named: "examplebike")?.jpegData(compressionQuality: 1.0),
            fullName: "herris",
            desc: "stavo battendo uno a suon di proof e nel frattempo mi hanno rubato la bici... disastro...",
            remarks: "presentava 5 sticker",
            phoneNumber: "+39 123 456 7890",
            email: "theproof@zestymail.com"
        ),
        Report(
            spot: ParkingSpot.sampleData[1],
            type: .found,
            creationDate: Date(timeIntervalSince1970: 1696257420),
            imageData: UIImage(named: "examplebike")?.jpegData(compressionQuality: 1.0),
            fullName: "tûbarao rainbow6siege",
            desc: "fra non stavo facendo nulla come il solito, quando ho deciso di andare al despar e ho trovato questa...",
            remarks: "nessuno",
            phoneNumber: "+39 123 456 7890",
            email: "icantstopplayingrainbowsixsiegeandbeinganeet@yahoo.com"
        )
    ]
}	

func newReport() -> Report {
    return Report(spot: nil, type: .found, creationDate: Date(), imageData: nil)
}
