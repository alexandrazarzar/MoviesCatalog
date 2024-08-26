//
//  MovieDetailsView.swift
//  MoviesCatalog
//
//  Created by avz on 24/08/24.
//

import SwiftUI
import SwiftData

struct MovieDetailsView: View {
    @ObservedObject var viewModel: MovieDetailsViewModel
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        ZStack {
            backgroundView
            
            if let movie = viewModel.movie {
                movieDetailsContent(for: movie)
            } else if let errorMessage = viewModel.errorMessage {
                ErrorView(errorMessage)
            } else {
                ProgressView()
            }
        }
        .onAppear {
            viewModel.onMovieDetailsAppear()
        }
    }
    
    private var backgroundView: some View {
        Color.appBackground
            .ignoresSafeArea()
    }
    
    private func movieDetailsContent(for movie: Movie) -> some View {
        VStack(spacing: 10) {
            movieTitle
            releaseDate
            posterView(for: movie)
            ratingsAndRuntime
            genres
            overview
            watchedButton(for: movie)
        }
        .padding()
    }
    
    private var movieTitle: some View {
        Text(viewModel.movie?.title ?? "")
            .font(.largeTitle)
            .bold()
            .accessibilityIdentifier("MovieTitle")
    }
    
    private var releaseDate: some View {
        Text(viewModel.releaseDate)
            .font(.subheadline)
    }
    
    private var ratingsAndRuntime: some View {
        HStack {
            RatingView(voteAverage: viewModel.movie?.voteAverage ?? "n/a")
            Text(viewModel.displayRuntime)
                .accessibilityLabel(Text(viewModel.voiceOverFriendlyRuntime))
        }
    }
    
    private var genres: some View {
        Text(viewModel.genresText)
        .bold()    }
    
    private var overview: some View {
        Text(viewModel.movie?.overview ?? "")
            .multilineTextAlignment(.leading)
    }
    
    private func watchedButton(for movie: Movie) -> some View {
        Button(action: {
            modelContext.insert(WatchedMovie(movieID: movie.title))
        }) {
            Text(Constants.Text.registerButtonText)
        }
        .buttonStyle(.bordered)
    }
    
    private func posterView(for movie: Movie) -> some View {
        MoviePosterView(imageURL: movie.posterPath,
                        relativeFrameSize: Constants.Numbers.posterRelativeFrameSize)
        .cornerRadius(Constants.Numbers.posterCornerRadius)
        .shadow(color: .cellShadow, radius: Constants.Numbers.posterShadowRadius)
        .padding()
    }
    
    struct Constants {
        enum Text {
            static let registerButtonText = "Register in journal"
        }
        enum Numbers {
            static let posterRelativeFrameSize: CGFloat = 0.5
            static let posterShadowRadius: CGFloat = 10
            static let posterCornerRadius: CGFloat = 15
            static let ratingViewCornerRadius: CGFloat = 7
            static let ratingViewMaxWidth: CGFloat = 60
            static let ratingViewMaxHeight: CGFloat = 25
            static let horizontalSpacing: CGFloat = 5
        }
    }
}

#Preview {
    MovieDetailsView(viewModel: MovieDetailsViewModel(movieID: 123))
}
