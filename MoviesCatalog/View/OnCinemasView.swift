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
                            Text(movie.title)
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
