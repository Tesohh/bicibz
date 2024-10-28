//
//  ReportsView.swift
//  bikeparking
//
//  Created by Simone Tesini on 28/10/24.
//

import SwiftUI

struct ReportsView: View {
    var body: some View {
        NavigationStack { // TEMP:
            List {
                ReportListItem(report: Report.sampleData[0])
                ReportListItem(report: Report.sampleData[1])
                ReportListItem(report: Report.sampleData[2])
            }
            .navigationTitle("Segnalazioni")
        }
    }
}

#Preview {
    ReportsView()
}
