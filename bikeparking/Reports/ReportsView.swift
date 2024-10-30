//
//  ReportsView.swift
//  bikeparking
//
//  Created by Simone Tesini on 28/10/24.
//

import SwiftUI
import SwiftData

struct ReportsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Report.creationDate, order: .reverse) private var reports: [Report]
    
    var body: some View {
        NavigationStack { // TEMP:
            List {
                ForEach(reports) { report in
                    ReportListItem(report: report)
                }
            }
            .navigationTitle("Segnalazioni")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(
                        destination: NewReportView(report: newReport(), callback: { report in
                            modelContext.insert(report)
                        }),
                        label: {Image(systemName: "plus")}
                    )
                }
            }
            .onAppear {
                print(modelContext, modelContext.container)
                guard reports.isEmpty else { return }
                for s in Report.sampleData {
                    modelContext.insert(s)
                }
            }
        }
    }
}

#Preview {
    ReportsView()
        .modelContainer(for: Report.self, inMemory: true)
}
