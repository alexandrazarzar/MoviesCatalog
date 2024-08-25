//
//  OnCinemasView.swift
//  MoviesCatalog
//
//  Created by avz on 22/08/24.
//

import SwiftUI

struct MoviesListView: View {
    @ObservedObject var viewModel = MoviesListViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                backgroundView
                
                if !viewModel.movies.isEmpty {
                    inTheatersContent
                } else if let errorDescription = viewModel.errorDescription {
                    errorView(errorDescription)
                } else {
                    ProgressView()
                }
            }
        }
        .tint(.cinemaRed)
    }
    
    private var backgroundView: some View {
        Color.appBackground
            .ignoresSafeArea()
    }
    
    private var inTheatersContent: some View {
        VStack(alignment: .leading, spacing: 0) {
            headerView
            movieListView
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    private var headerView: some View {
        HStack {
            Label("In Theaters", systemImage: "popcorn")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding([.bottom, .leading])
                .foregroundColor(.white)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(.cinemaRed)
    }
    
    private var movieListView: some View {
        ScrollView {
            ForEach(viewModel.movies, id: \.self) { movie in
                NavigationLink(destination: MovieDetailsView(viewModel: MovieDetailsViewModel(movieID: movie.id))) {
                    MovieListCellView(viewModel: MovieListCellViewModel(movie: movie))
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.vertical)
        }
    }
    
    private func errorView(_ errorDescription: String) -> some View {
        VStack {
            Text("⚠️ \(errorDescription)")
        }
    }
}

#Preview {
    MoviesListView()
}
