//
//  OnCinemasView.swift
//  MoviesCatalog
//
//  Created by avz on 22/08/24.
//

import SwiftUI

struct OnCinemasView: View {
    @ObservedObject var viewModel = OnCinemasViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                backgroundView
                VStack(alignment: .leading, spacing: 0) {
                    headerView
                    mainContent
                }
                .edgesIgnoringSafeArea(.bottom)
            }
        }
        .tint(.ratingView)
    }
    
    private var backgroundView: some View {
        Color.appBackground
            .ignoresSafeArea()
    }
    
    private var headerView: some View {
        HStack {
            Text("In Theaters now")
                .font(.largeTitle)
                .fontWeight(.black)
                .padding([.bottom, .leading])
                .foregroundColor(.black)
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.ratingView)
    }
    
    private var mainContent: some View {
        Group {
            if !viewModel.movies.isEmpty {
                movieListView
            } else if let errorDescription = viewModel.errorDescription {
                errorView(errorDescription)
            } else {
                ProgressView()
            }
        }
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
        Text("⚠️ \(errorDescription)")
    }
}

#Preview {
    OnCinemasView()
}
