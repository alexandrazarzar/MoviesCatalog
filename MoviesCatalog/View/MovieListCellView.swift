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
        HStack {
            moviePoster
                .scaledToFit()
                .containerRelativeFrame(.horizontal) { size, axis in
                    size * 0.2
                }
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .font(.title3)
                    .bold()
                HStack {
                    ratingView
                    Text(viewModel.releaseDate)
                }
                .padding(.bottom)
            }
        }
        
    }
    
    var ratingView: some View {
        RoundedRectangle(cornerRadius: 7)
            .fill(.gray)
            .overlay(
                HStack(spacing: 5) {
                    Image(systemName: "star.fill")
                    Text(viewModel.voteAverage)
                }
                    .font(.caption)
                    .foregroundColor(.white)
            )
            .frame(maxWidth: 60, maxHeight: 25)
    }
    
    var moviePoster: some View {
        AsyncImage(url: viewModel.posterURL) { phase in
            if let image = phase.image {
                image
                    .resizable()
            } else if phase.error != nil {
                Image(systemName: "exclamationmark.octagon.fill")
                    .resizable()
            } else {
                ProgressView()
            }
        }
    }
}

#Preview {
    MovieListCellView(viewModel: MovieListCellViewModel(movie: Movie(id: 1, title: "Title", voteAverage: 9.78676, runtime: nil, releaseDate: "2008-08-08", genres: nil, posterPath: "1E5baAaEse26fej7uHcjOgEE2t2.jpg")))
}
