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
            movieTitle
            releaseDate
            posterView(for: movie)
            ratingsAndRuntime
            genres
            overview
            Spacer()
            watchedButton
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
    
    private func posterView(for movie: Movie) -> some View {
        MoviePosterView(imageURL: movie.posterPath,
                        relativeFrameSize: MovieDetailsConstants.posterRelativeFrameSize)
            .cornerRadius(MovieDetailsConstants.posterCornerRadius)
            .shadow(color: .cellShadow, radius: MovieDetailsConstants.posterShadowRadius)
            .padding()
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
            .bold()
            .padding(.vertical)
    }
    
    private var overview: some View {
        Text(viewModel.movie?.overview ?? "")
            .multilineTextAlignment(.leading)
    }
    
    private var watchedButton: some View {
        Button(action: {
            modelContext.insert(WatchedMovie(movieID: viewModel.movie?.title ?? ""))

        }) {
            Text("Register in journal")
                .foregroundColor(.white)
                .cornerRadius(10)
                .background(.blue)
        }
    }
    
    struct MovieDetailsConstants {
        static let posterRelativeFrameSize: CGFloat = 0.5
        static let posterShadowRadius: CGFloat = 10
        static let posterCornerRadius: CGFloat = 15
        static let ratingViewCornerRadius: CGFloat = 7
        static let ratingViewMaxWidth: CGFloat = 60
        static let ratingViewMaxHeight: CGFloat = 25
        static let horizontalSpacing: CGFloat = 5
    }
}
