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
            Text(movie.voiceOverFriendlyReleaseDate)
                .font(.subheadline)
            posterView(for: movie)
            HStack {
                ratingView(for: movie)
                Text(movie.runtime)
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
    
    private func ratingView(for movie: Movie) -> some View {
        RoundedRectangle(cornerRadius: Constant.ratingViewCornerRadius)
            .fill(Color.ratingView)
            .overlay(
                HStack(spacing: Constant.horizontalSpacing) {
                    Image(systemName: "star.fill")
                    Text(movie.voteAverage)
                }
                    .font(.caption)
                    .foregroundColor(.ratingText)
            )
            .frame(maxWidth: Constant.ratingViewMaxWidth, maxHeight: Constant.ratingViewMaxHeight)
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

