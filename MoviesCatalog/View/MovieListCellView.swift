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
                MoviePosterView(imageURL: viewModel.posterURL, relativeFrameSize: 0.2)
                VStack(alignment: .leading) {
                    Text(viewModel.title)
                        .font(.title3)
                        .bold()
                    HStack {
                        ratingView
                        Text(viewModel.releaseDate)
                    }
                }
            }
            .padding(10)
        }
        .padding(.horizontal)
    }
    
    var cardWithShadow: some View {
        RoundedRectangle(cornerRadius: 10)
            .fill(.movieCell)
            .shadow(color: .cellShadow, radius: 3, x: 0, y: 2)
    }
    
    var ratingView: some View {
        RoundedRectangle(cornerRadius: 7)
            .fill(.ratingView)
            .overlay(
                HStack(spacing: 5) {
                    Image(systemName: "star.fill")
                    Text(viewModel.voteAverage)
                }
                    .font(.caption)
                    .foregroundColor(.ratingText)
            )
            .frame(maxWidth: 60, maxHeight: 25)
    }
}

#Preview {
    MovieListCellView(viewModel: MovieListCellViewModel(movie: Movie(id: 1, title: "Title", voteAverage: 9.78676, runtime: nil, releaseDate: "2008-08-08", genres: nil, posterPath: "1E5baAaEse26fej7uHcjOgEE2t2.jpg")))
        .padding(.vertical, 300)
}
