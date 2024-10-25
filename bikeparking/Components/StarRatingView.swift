import SwiftUI

struct StarRatingView: View {
    @Binding var rating: UInt8  // Use UInt8 for the rating
    var maxRating: Int = 5      // Default maximum is 5 stars
    var starSize: CGFloat = 30  // Customizable star size
    var starColor: Color = .yellow  // Customizable star color
    
    // Map the UInt8 rating (0-255) to the 0-5 star range
    private var starRating: Double {
        return Double(rating) / 255.0 * Double(maxRating)
    }
    
    var body: some View {
        HStack {
            ForEach(1...maxRating, id: \.self) { index in
                // Determine if the star is full, half, or empty based on the rating
                starType(for: index)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: starSize, height: starSize)
                    .foregroundColor(starColor)
                    .onTapGesture {
                        // Update the rating based on the user's tap
                        updateRating(for: index)
                    }
            }
        }
    }
    
    // Determine whether the star should be full, half, or empty based on the index
    private func starType(for index: Int) -> Image {
        if Double(index) <= starRating {
            return Image(systemName: "star.fill")
        } else if Double(index) - 0.5 <= starRating {
            return Image(systemName: "star.leadinghalf.fill")
        } else {
            return Image(systemName: "star")
        }
    }
    
    // Update the rating when a star is tapped, and convert it back to UInt8
    private func updateRating(for index: Int) {
        let newStarRating = Double(index)
        let newRating = UInt8(newStarRating / Double(maxRating) * 255.0)
        rating = newRating
    }
}

struct StarRatingView_Previews: PreviewProvider {
    @State static var previewRating: UInt8 = 127  // Default rating as UInt8
    
    static var previews: some View {
        StarRatingView(rating: $previewRating)
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
