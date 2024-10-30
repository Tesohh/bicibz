//
//  ReportListItem.swift
//  bikeparking
//
//  Created by Simone Tesini on 28/10/24.
//

import SwiftUI

struct ReportListItem: View {
    var report: Report
    var body: some View {
        NavigationLink(destination: ReportDetailView(report: report)) {
            VStack(alignment: .leading) {
                if let image = report.getAppleImage() {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 100)
                        .cornerRadius(2)
                }               
                
                ReportTypeView(report: report)
                
                Text(report.title()).frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    NavigationStack {
        List {
            ReportListItem(report: Report.sampleData[0])
            ReportListItem(report: Report.sampleData[1])
            ReportListItem(report: Report.sampleData[2])
        }
    }
}
