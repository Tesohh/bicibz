//
//  Tip.swift
//  bikeparking
//
//  Created by Simone Tesini on 02/11/24.
//

import SwiftData
import PhotosUI

@Model
final class Tip {
    var title: String
    var desc: String
    var imageData: Data?
    
    init(title: String, desc: String, imageData: Data? = nil) {
        self.title = title
        self.desc = desc
        self.imageData = imageData
    }

    func setAppleImage(_ image: UIImage) {
        self.imageData = image.jpegData(compressionQuality: 0.8)
    }
    
    func getAppleImage() -> UIImage? {
        guard let imageData = imageData else { return nil }
        return UIImage(data: imageData)
    }
}

extension Tip {
    static var sampleData = [
        Tip(title: "come non farsi rubare la bici",
            desc: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
            imageData: UIImage(named: "examplebike")?.jpegData(compressionQuality: 1.0))
    ]
}
