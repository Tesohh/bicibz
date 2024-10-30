//
//  StringUnbindingExtension.swift
//  bikeparking
//
//  Created by Simone Tesini on 30/10/24.
//

import SwiftUI

extension Binding where Value == String? {
    func unwrap(defaultValue: String = "") -> Binding<String> {
        return Binding<String>(
            get: {
                return self.wrappedValue ?? defaultValue
            },
            set: {
                self.wrappedValue = $0
            }
        )
    }
}
