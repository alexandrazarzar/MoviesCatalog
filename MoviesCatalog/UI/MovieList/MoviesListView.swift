//
//  OnCinemasView.swift
//  MoviesCatalog
//
//  Created by avz on 22/08/24.
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject var viewModel: MoviesListViewModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundView
                
                if !viewModel.movies.isEmpty {
                    inTheatersContent
                } else if let errorDescription = viewModel.errorDescription {
                    ErrorView(errorDescription)
                } else {
                    ProgressView()
                }
            }
            .onAppear(perform: {
                viewModel.onViewAppear()
            })
        }
        .tint(.cinemaRed)
    }
    
    private var backgroundView: some View {
        Color.appBackground
            .ignoresSafeArea()
    }
    
    private var inTheatersContent: some View {
        VStack(alignment: .leading, spacing: 0) {
            HeaderView(headerText: Constants.Text.header)
            movieListView
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private var movieListView: some View {
        ScrollView {
            ForEach(viewModel.movies, id: \.self) { movie in
                let detailsViewModel = MovieDetailsViewModel(movieID: movie.id)
                let detailsView = MovieDetailsView(viewModel: detailsViewModel)
                
                NavigationLink(destination: detailsView) {
                    MovieListCellView(viewModel: MovieListCellViewModel(movie: movie))
                }
                .simultaneousGesture(TapGesture().onEnded {
                    viewModel.onMovieCellTapped()
                })
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.vertical)
        }
    }
    
    enum Constants {
        enum Text {
            static let header = "In Theaters"
        }
    }
}

#Preview {
    MoviesListView(viewModel: MoviesListViewModel())
}
