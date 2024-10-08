//
//  RatingView.swift
//  MoviesCatalog
//
//  Created by avz on 25/08/24.
//

import SwiftUI

struct RatingView: View {
    let voteAverage: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: Constants.Numbers.ratingCornerRadius)
            .fill(.cinemaRed)
            .overlay(
                HStack(spacing: Constants.Numbers.spaceFromIconToText) {
                    Image(systemName: Constants.Image.starIcon)
                        .accessibilityLabel(Text(Constants.Accessibility.iconAccessibilityLabel))
                    Text(voteAverage)
                }
                    .font(.caption)
                    .foregroundColor(.white)
            )
            .frame(maxWidth: Constants.Numbers.ratingViewMaxWidth,
                   maxHeight: Constants.Numbers.ratingViewMaxHeight)
            .accessibilityElement(children: .combine)
    }
    
    enum Constants {
        enum Numbers {
            static let ratingCornerRadius: CGFloat = 7
            static let ratingViewMaxWidth: CGFloat = 60
            static let ratingViewMaxHeight: CGFloat = 25
            static let spaceFromIconToText: CGFloat = 5
        }
        
        enum Image {
            static let starIcon = "star.fill"
        }
        
        enum Accessibility {
            static let iconAccessibilityLabel = "rating"
        }
    }
}

#Preview {
    RatingView(voteAverage: "8.90")
}
