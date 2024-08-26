//
//  WatchedMoviesList.swift
//  MoviesCatalog
//
//  Created by avz on 26/08/24.
//

import SwiftUI
import SwiftData

struct WatchedMoviesList: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var movies: [WatchedMovie]
    
    var body: some View {
        List {
            ForEach(movies, id: \.self) { movie in
                HStack {
                    Text(movie.title)
                    Spacer()
                    Text(movie.watchedDate.formatReleaseDateToDisplay())
                        .foregroundColor(.gray)
                }
            }
            .onDelete(perform: { offsets in
                let movieToDelete = movies[offsets.first ?? 0]
                modelContext.delete(movieToDelete)
            })
        }
    }
}


#Preview {
    WatchedMoviesList()
}
