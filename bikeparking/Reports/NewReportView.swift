//
//  NewRatingView.swift
//  bikeparking
//
//  Created by Simone Tesini on 24/10/24.
//

import SwiftUI
import PhotosUI

struct NewReportView: View {
    @Environment(\.dismiss) private var dismiss
    @State var report: Report
    @State private var selectedPhotoItem: PhotosPickerItem? = nil
    @State private var selectedImageData: Data? = nil
    
    var title: String = "Nuova segnalazione"
    var callback: (Report) -> Void = {_ in}
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
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
                
                // Image selection section
                Section {
                    if let imageData = selectedImageData, let uiImage = UIImage(data: imageData) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    } else {
                        Text("Nessuna immagine selezionata")
                            .frame(height: 200)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(8)
                    }
                    
                    // PhotosPicker for selecting the image
                    PhotosPicker(selection: $selectedPhotoItem, matching: .images, photoLibrary: .shared()) {
                        Text("Seleziona una foto")
                    }
                    .onChange(of: selectedPhotoItem) { newItem in
                        Task {
                            if let newItem = newItem {
                                if let data = try? await newItem.loadTransferable(type: Data.self) {
                                    selectedImageData = data
                                    report.imageData = data
                                }
                            }
                        }
                    }
                } header: {
                    Text("Immagine")
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
