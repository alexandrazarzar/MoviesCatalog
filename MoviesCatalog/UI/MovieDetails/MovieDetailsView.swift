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
            Color.appBackground
            VStack {
                Text(viewModel.movie.title)
                    .font(.largeTitle)
                    .bold()
                Text(viewModel.movie.releaseDate)

                MoviePosterView(imageURL: viewModel.movie.posterPath, relativeFrameSize: 0.5)
                    .cornerRadius(15)
                    .shadow(color: .cellShadow, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                HStack {
                    ratingView
                    Text(viewModel.movie.runtime)
                }
                
                Text(genresText())
                Text(viewModel.movie.overview)
                    .multilineTextAlignment(.center)
                    .padding()

            }
        }
        .ignoresSafeArea()
    }
    
    var ratingView: some View {
        RoundedRectangle(cornerRadius: 7)
            .fill(.ratingView)
            .overlay(
                HStack(spacing: 5) {
                    Image(systemName: "star.fill")
                    Text(viewModel.movie.voteAverage)
                }
                    .font(.caption)
                    .foregroundColor(.ratingText)
            )
            .frame(maxWidth: 60, maxHeight: 25)
    }
    
    func genresText() -> String {
        var str = ""
        for genre in viewModel.movie.genres {
            str.append("\(genre) • ")
        }
        return str
    }

}

#Preview {
    MovieDetailsView(viewModel: MovieDetailsViewModel(movie: Movie(movieResponse: MovieResponse(id: 1, title: "Nice movie title", overview: "This is movie overview This is movie overview This is movie overview This is movie overview This is movie overview This is movie overview This is movie overview This is movie overview", voteAverage: 8.7935, releaseDate: "2008-08-08", posterPath: "1E5baAaEse26fej7uHcjOgEE2t2.jpg", runtime: 100, genres: [MovieGenre(name: "Romance")]))))
}
