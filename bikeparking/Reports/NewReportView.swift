//
//  NewRatingView.swift
//  bikeparking
//
//  Created by Simone Tesini on 24/10/24.
//

import SwiftUI

struct NewReportView: View {
    @Environment(\.dismiss) private var dismiss
    @State var report: Report
    
    var title: String = "Nuova segnalazione"
    var callback: (Report) -> Void = {_ in}
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
//                    Picker(selection: $report.barebonesLocation, label: Text("Tipo di posizione")) {
//                        Text("Nessuna").tag(BarebonesReportLocation.none)
//                        Text("Dalla mappa").tag(BarebonesReportLocation.coords)
//                        Text("Parcheggio").tag(BarebonesReportLocation.spot)
//                    }
                    
//                    if $report.barebonesLocation == .none { }
//                    else if $report.barebonesLocation == .coords { /* TODO: */ }
//                    else if $report.barebonesLocation == .spot {
////
//                    }
                    
                    
                    NavigationLink(report.spot == nil ? "Seleziona un parcheggio..." : "\(report.title())") {
                        ParkingSpotPickerView(spots: ParkingSpot.sampleData) { spot in
                            report.spot = spot
                        }
                    }
                    Picker(selection: $report.type, label: Text("Tipo di segnalazione")) {
                        Text("Ritrovamento").tag(ReportType.found)
                        Text("Furto").tag(ReportType.theft)
                    }
                    
                }
                
                Section {
                    Text("qui ci andrà la foto...")
                }
                
                Section {
                    TextField(text: $report.desc.unwrap()) {
                        Text("Descrizione")
                    }
                }
                
                Section {
                    TextField(text: $report.fullName.unwrap()) {
                        Text("Nome e cognome")
                    }
                    TextField(text: $report.phoneNumber.unwrap()) {
                        Text("Numero di telefono")
                    }
                    TextField(text: $report.email.unwrap()) {
                        Text("E-mail")
                    }
                    TextField(text: $report.facebook.unwrap()) {
                        Text("Nome su Facebook")
                    }
                    TextField(text: $report.instagram.unwrap()) {
                        Text("Tag su Instagram")
                    }
                }
                header: { Text("Contatti") }
                footer: { Text("campi non obbligatori, ma riempine almeno uno") }
                
//                Section("Sicurezza") {
//                    Toggle("Recintata?", isOn: $rating.fenced)
//                    Toggle("Zona ad alto traffico?", isOn: $rating.crowded)
//                    Toggle("Sorvegliata?", isOn: $rating.surveilled)
//                    HStack {
//                        Text("Zona poco sospetta")
//                        Spacer()
//                        StarRatingView(rating: $rating.lowCrimeRate, starSize: 20, starColor: .orange)
//                    }
//                }
//                
//                Section("Comodità") {
//                    HStack {
//                        Text("Qualità del parcheggio")
//                        Spacer()
//                        StarRatingView(rating: $rating.quality, starSize: 20, starColor: .orange)
//                    }
//                    HStack {
//                        Text("Capacità")
//                        Spacer()
//                        StarRatingView(rating: $rating.capacity, starSize: 20, starColor: .orange)
//                    }
//                    HStack {
//                        Text("Comodità della zona")
//                        Spacer()
//                        StarRatingView(rating: $rating.locationQuality, starSize: 20, starColor: .orange)
//                    }
//                }
                Button("Invia") {
                    callback(report)
                    dismiss()
                }
            }.navigationTitle("Nuova segnalazione").navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NewReportView(report: newReport())
}
