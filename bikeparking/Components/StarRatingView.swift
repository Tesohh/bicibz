//
//  StarRatingView.swift
//  bikeparking
//
//  Created by Simone Tesini on 24/10/24.
//

import SwiftUI

struct StarRatingView: View {
    var rating: Double  // Supports decimal values
    var maxRating: Int = 5  // Default to a 5-star rating system
    var color: Color = .orange
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(1...maxRating, id: \.self) { index in
                // Determine if the current index should be a full, half, or empty star
                if Double(index) <= rating {
                    // Full star if the index is less than or equal to the rating
                    Image(systemName: "star.fill")
                        .foregroundColor(color)
                } else if Double(index) - 0.5 <= rating {
                    Image(systemName: "star.leadinghalf.fill")
                        .foregroundColor(color)
                } else {
                    Image(systemName: "star")
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
        StarRatingView(rating: 3.5)
    }
}
