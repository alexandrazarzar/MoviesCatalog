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
        VStack {
            titleAndReleaseDate(for: movie)
            ratingsAndRuntime(for: movie)
            posterView(for: movie)
            watchedButton(for: movie)
            genres
            overview(for: movie)
            Spacer()
        }
        .padding()
    }
    
    private func titleAndReleaseDate(for movie: Movie) -> some View {
        VStack {
            Text(movie.title)
                .font(.largeTitle)
                .bold()
                .accessibilityIdentifier("MovieTitle")
                Text(viewModel.releaseDate)
                    .font(.subheadline)
        }
        .padding(.bottom)
    }
    
    private func ratingsAndRuntime(for movie: Movie) -> some View {
        HStack {
            RatingView(voteAverage: movie.voteAverage)
            Text(viewModel.displayRuntime)
                .accessibilityLabel(Text(viewModel.voiceOverFriendlyRuntime))
        }
    }
    
    private var genres: some View {
        Text(viewModel.genresText)
            .fontWeight(.heavy)
            .padding(.top)
    }
    
    private func overview(for movie: Movie) -> some View {
        Text(movie.overview)
            .multilineTextAlignment(.leading)
    }
    
    private func watchedButton(for movie: Movie) -> some View {
        Button(action: {
            modelContext.insert(WatchedMovie(movieID: movie.title))
        }) {
            Text(Constants.Text.registerButtonText)
                .font(.caption)
        }
        .buttonStyle(.bordered)
    }
    
    private func posterView(for movie: Movie) -> some View {
        MoviePosterView(imageURL: movie.posterPath,
                        relativeFrameSize: Constants.Numbers.posterRelativeFrameSize)
        .cornerRadius(Constants.Numbers.posterCornerRadius)
        .shadow(color: .cellShadow, radius: Constants.Numbers.posterShadowRadius)
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
