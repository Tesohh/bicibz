import SwiftUI

struct StaticStarRatingView: View {
    var rating: UInt8   // Rating in half-star increments (0 - 10)
    var maxRating: Int = 5  // Default to a 5-star rating system

    private var starValue: Double {
        return Double(rating) / 255.0 * Double(maxRating)
    }
    
    var body: some View {
        HStack {
            ForEach(1...maxRating, id: \.self) { index in
                // Calculate the threshold for each star position
                let currentStarThreshold = Double(index)

                if starValue >= currentStarThreshold {
                    // Full star
                    Image(systemName: "star.fill")
                        .foregroundColor(.orange)
                } else if starValue >= currentStarThreshold - 0.5 {
                    // Half star
                    Image(systemName: "star.leadinghalf.fill")
                        .foregroundColor(.orange)
                } else {
                    // Empty star
                    Image(systemName: "star")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct StaticStarRatingView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StaticStarRatingView(rating: STAR*3)  // 3.5 stars
            StaticStarRatingView(rating: STAR*4 + 26) // 5 stars
            StaticStarRatingView(rating: STAR*1)  // 0 stars
        }
        .padding()
    }
}

