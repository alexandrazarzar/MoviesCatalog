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
            List {
                if let movies = viewModel.movies {
                    ForEach(movies, id: \.self) { movie in
                        Text(movie.title)
                    }
                } else {
                    Text("Could not load")
                }
            }
            .listStyle(.inset)
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
