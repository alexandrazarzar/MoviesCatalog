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
            content
        }
        .padding(.horizontal)
    }
    
    private var content: some View {
        HStack {
            posterView
            movieDetails
            Spacer()
            chevronIcon
        }
        .padding(Constants.Numbers.cardPadding)
    }
    
    private var posterView: some View {
        MoviePosterView(imageURL: viewModel.posterURL, relativeFrameSize: Constants.Numbers.imgRelativeFrameSize)
    }
    
    private var movieDetails: some View {
        VStack(alignment: .leading) {
            Text(viewModel.title)
                .font(.title3)
                .bold()
            HStack {
                RatingView(voteAverage: viewModel.voteAverage)
                Text(viewModel.displayedReleaseDate)
                    .accessibilityLabel(Text(viewModel.voiceOverFriendlyReleaseDate))
            }
        }
    }
    
    private var chevronIcon: some View {
        Image(systemName: Constants.Image.chevronRight)
            .padding(.trailing)
    }
    
    private var cardWithShadow: some View {
        RoundedRectangle(cornerRadius: Constants.Numbers.cardCornerRadius)
            .fill(.movieCell)
            .shadow(color: .cellShadow, radius: Constants.Numbers.cardShadowRadius)
    }
}

struct Constants {
    enum Image {
        static let chevronRight = "chevron.right"
    }
    
    enum Numbers {
        static let cardCornerRadius: CGFloat = 10
        static let cardShadowRadius: CGFloat = 3
        static let cardPadding: CGFloat = 10
        static let imgRelativeFrameSize: CGFloat = 0.2
    }
}

#Preview {
    MovieListCellView(viewModel: MovieListCellViewModel(movie: Movie(movieResponse: MovieResponse(id: 1, title: "Title", overview: "This is movie overview", voteAverage: 8.7935, releaseDate: "2008-08-08", posterPath: "1E5baAaEse26fej7uHcjOgEE2t2.jpg", runtime: 100, genres: nil))))
}
