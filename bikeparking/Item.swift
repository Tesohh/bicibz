//
//  Item.swift
//  bikeparking
//
//  Created by Simone Tesini on 19/10/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
