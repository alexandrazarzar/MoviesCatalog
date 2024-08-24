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
        VStack(alignment: .leading) {
            Text("🍿 On cinemas")
                .font(.largeTitle)
                .fontWeight(.black)
            
            if let movies = viewModel.movies {
                ScrollView {
                    ForEach(movies, id: \.self) { movie in
                        let cellViewModel = MovieListCellViewModel(movie: movie)
                        MovieListCellView(viewModel: cellViewModel)
                    }
                    .padding(.vertical)
                }
            } else if viewModel.errorDescription != nil {
                Text("⚠️ \(String(describing: viewModel.errorDescription))")
            } else {
                ProgressView()
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear() {
            viewModel.loadMoviesOnCinema()
        }
    }
}

#Preview {
    OnCinemasView()
}
