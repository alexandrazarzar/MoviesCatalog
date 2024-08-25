//
//  MovieListCellView.swift
//  MoviesCatalog
//
//  Created by Alexandra Viana on 23/08/24.
//

import SwiftUI

struct MovieListCellView: View {
    @ObservedObject var viewModel: MovieListCellViewModel
    
    var body: some View {
        ZStack(alignment: .leading) {
            cardWithShadow
            HStack {
                MoviePosterView(imageURL: viewModel.posterURL, relativeFrameSize: Constants.imgRelativeFrameSize)
                VStack(alignment: .leading) {
                    Text(viewModel.title)
                        .font(.title3)
                        .bold()
                    HStack {
                        ratingView
                        Text(viewModel.displayedReleaseDate)
                            .accessibilityLabel(Text(viewModel.voiceOverFriendlyReleaseDate))
                    }
                }
            }
            .padding(Constants.cardPadding)
        }
        .padding(.horizontal)
    }
    
    var cardWithShadow: some View {
        RoundedRectangle(cornerRadius: Constants.cardCornerRadius)
            .fill(.movieCell)
            .shadow(color: .cellShadow, radius: Constants.cardShadowRadius)
    }
    
    var ratingView: some View {
        RoundedRectangle(cornerRadius: Constants.ratingCornerRadius)
            .fill(.ratingView)
            .overlay(
                HStack(spacing: 5) {
                    Image(systemName: "star.fill")
                        .accessibilityLabel(Text("rating"))
                    Text(viewModel.voteAverage)
                }
                    .font(.caption)
                    .foregroundColor(.ratingText)
            )
            .frame(maxWidth: Constants.ratingViewMaxWidth, maxHeight: Constants.ratingViewMaxHeight)
            .accessibilityElement(children: .combine)
    }
    
    enum Constants {
        static let cardCornerRadius: CGFloat = 10
        static let cardShadowRadius: CGFloat = 3
        static let cardPadding: CGFloat = 10
        static let imgRelativeFrameSize: CGFloat = 0.2
        static let ratingCornerRadius: CGFloat = 7
        static let ratingViewMaxWidth: CGFloat = 60
        static let ratingViewMaxHeight: CGFloat = 25
    }
}

#Preview {
    MovieListCellView(viewModel: MovieListCellViewModel(movie: Movie(movieResponse: MovieResponse(id: 1, title: "Title", overview: "This is movie overview", voteAverage: 8.7935, releaseDate: "2008-08-08", posterPath: "1E5baAaEse26fej7uHcjOgEE2t2.jpg", runtime: 100, genres: nil))))
}
