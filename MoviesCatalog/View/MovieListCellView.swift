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
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .bold()
                Text(viewModel.releaseDate)
            }
            Spacer()
            RoundedRectangle(cornerRadius: 10)
                .fill(.blue)
                .overlay(
                    HStack {
                        Image(systemName: "star.fill")
                        Text(viewModel.voteAverage)
                    }
                        .foregroundColor(.white)
                )
                .padding()
        }
    }
}

#Preview {
    MovieListCellView(viewModel: MovieListCellViewModel(movie: Movie(id: 1, title: "Title", voteAverage: 9.78676, runtime: nil, releaseDate: "08-08-2008", genres: nil)))
}
