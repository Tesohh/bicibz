//
//  ReportDetail.swift
//  bikeparking
//
//  Created by Simone Tesini on 29/10/24.
//

import SwiftUI

struct ReportDetailView: View {
    var report: Report
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if let image = report.getAppleImage() {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350)
                        .cornerRadius(10)
                        .padding(.bottom)
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        ReportTypeView(report: report)
                        if report.type == .found {
                            Text("da \(report.fullName ?? "[anonimo]")").foregroundStyle(.secondary)
                        }
                    }
                    Text("in data \(report.creationDate.formatted())").foregroundStyle(.secondary)
                    Text(report.title())
                }.padding(.bottom)
                
                VStack(alignment: .leading) {
                    Text("DESCRIZIONE")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.secondary)
                    
                    Text("\"\(report.desc ?? "nessuna descrizione...")\"")
                        .font(.body)
                        .italic()
                        .padding()
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(8)
                }.padding(.bottom)
                
                VStack(alignment: .leading) {
                    Text("CONTATTI")
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.secondary)
                    
                    if let phoneNumber = report.phoneNumber {
                        HStack {
                            Image(systemName: "phone")
                            Link(phoneNumber, destination: URL(string: "tel:\(phoneNumber)")!)
                        }
                    }
                    if let email = report.email {
                        HStack {
                            Image(systemName: "envelope.fill")
                            Link(email, destination: URL(string: "email:\(email)")!)
                        }
                    }
                    if let facebook = report.facebook {
                        HStack {
                            Image(systemName: "f.square.fill")
                            Text(" Facebook: \(facebook)")
                        }
                    }
                    if let instagram = report.instagram {
                        HStack {
                            Image(systemName: "camera.fill")
                            Text("Instagram: \(instagram)")
                        }
                    }
                }
                
            }.frame(maxWidth: .infinity).padding()
            Spacer()
            .navigationTitle(report.title())
        }
    }
}

#Preview {
    ReportDetailView(report: Report.sampleData[1])
}
