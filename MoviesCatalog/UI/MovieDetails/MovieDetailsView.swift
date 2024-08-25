//
//  MovieDetailsView.swift
//  MoviesCatalog
//
//  Created by avz on 24/08/24.
//

import SwiftUI

struct MovieDetailsView: View {
    @ObservedObject var viewModel: MovieDetailsViewModel
    
    var body: some View {
        ZStack {
            backgroundView
            if let movie = viewModel.movie {
                movieDetailsView(for: movie)
            } else if let errorMessage = viewModel.errorMessage {
                Text("⚠️ \(errorMessage)")
            } else {
                ProgressView()
            }
        }
    }
    
    private var backgroundView: some View {
        Color.appBackground
            .ignoresSafeArea()
    }
    
    private func movieDetailsView(for movie: Movie) -> some View {
        VStack {
            Text(movie.title)
                .font(.largeTitle)
                .bold()
                .accessibilityIdentifier("MovieTitle")
            Text(viewModel.releaseDate)
                .font(.subheadline)
            posterView(for: movie)
            HStack {
                RatingView(voteAverage: movie.voteAverage)
                Text(viewModel.displayRuntime)
                    .accessibilityLabel(Text(viewModel.voiceOverFriendlyRuntime))
            }
            Text(genresText(for: movie.genres))
                .bold()
                .padding(.vertical)
            Text(movie.overview)
                .multilineTextAlignment(.leading)
            Spacer()
        }
        .padding()
    }
    
    private func posterView(for movie: Movie) -> some View {
        MoviePosterView(imageURL: movie.posterPath, relativeFrameSize: Constant.posterRelativeFrameSize)
            .cornerRadius(Constant.posterCornerRadius)
            .shadow(color: .cellShadow, radius: Constant.posterShadowRadius)
            .padding()
    }
    
    private func genresText(for genres: [String]) -> String {
        genres.joined(separator: " • ")
    }
    
    enum Constant {
        static let posterRelativeFrameSize: CGFloat = 0.5
        static let posterShadowRadius: CGFloat = 10
        static let posterCornerRadius: CGFloat = 15
        static let ratingViewCornerRadius: CGFloat = 7
        static let ratingViewMaxWidth: CGFloat = 60
        static let ratingViewMaxHeight: CGFloat = 25
        static let horizontalSpacing: CGFloat = 5
    }
}

#Preview {
    MovieDetailsView(viewModel: MovieDetailsViewModel(movieID: 1022789))
}

