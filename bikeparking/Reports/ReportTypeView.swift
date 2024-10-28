//
//  ReportTypeComponent.swift
//  bikeparking
//
//  Created by Simone Tesini on 29/10/24.
//

import SwiftUI

struct ReportTypeView: View {
    var report: Report
    var body: some View {
        switch report.type {
        case .theft:
            HStack {
                Image(systemName: "exclamationmark.bubble.fill")
                Text("Rubata")
            }.foregroundStyle(.red)
        case .found:
            HStack {
                Image(systemName: "lightbulb.fill")
                Text("Trovata")
            }.foregroundStyle(.blue)
            
        }
    }
}

#Preview {
    ReportTypeView(report: Report.sampleData[0])
    ReportTypeView(report: Report.sampleData[1])
}
