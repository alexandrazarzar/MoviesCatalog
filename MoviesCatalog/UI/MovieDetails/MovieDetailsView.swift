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
                    .foregroundColor(.red)
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
            Text("Released in \(movie.releaseDate)")
                .font(.subheadline)
            
            MoviePosterView(imageURL: movie.posterPath, relativeFrameSize: 0.5)
                .cornerRadius(15)
                .shadow(color: .cellShadow, radius: 10)
                .padding()
            
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
        MoviePosterView(imageURL: movie.posterPath, relativeFrameSize: 0.5)
            .cornerRadius(15)
            .shadow(color: .cellShadow, radius: 10)
    }
    
    private func ratingView(for movie: Movie) -> some View {
        RoundedRectangle(cornerRadius: 7)
            .fill(Color.ratingView)
            .overlay(
                HStack(spacing: 5) {
                    Image(systemName: "star.fill")
                    Text(movie.voteAverage)
                }
                    .font(.caption)
                    .foregroundColor(.ratingText)
            )
            .frame(maxWidth: 60, maxHeight: 25)
    }
    
    private func genresText(for genres: [String]) -> String {
        genres.joined(separator: " • ")
    }
}

#Preview {
    MovieDetailsView(viewModel: MovieDetailsViewModel(movieID: 1022789))
}
