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
                List {
                    ForEach(movies, id: \.self) { movie in
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .fontWeight(.semibold)
                            HStack {
                                if let releaseDate = movie.formattedReleaseDate {
                                    Text(releaseDate)
                                }
                                
                                Spacer()
                                
                                Text("⭐️\(movie.formattedVoteAverage)")
                            }
                        }
                    }
                }
                .listStyle(.inset)
            } else {
                Text("⚠️ \(viewModel.errorDescription)")
            }
        }
        .padding()
        .onAppear() {
            viewModel.loadMoviesOnCinema()
        }
    }
}

#Preview {
    OnCinemasView()
}
