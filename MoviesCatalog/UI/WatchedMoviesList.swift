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
    
    var groupedMovies: [Date: [WatchedMovie]] {
        Dictionary(grouping: movies, by: { $0.watchedDate })
    }
    
    var sortedGroupedMovies: [(key: Date, value: [WatchedMovie])] {
        groupedMovies.sorted { $0.key > $1.key }
    }

    var body: some View {
        List {
            ForEach(sortedGroupedMovies, id: \.key) { date, movies in
                Section(header: Text(date.formatReleaseDateToDisplay())) {
                    ForEach(movies, id: \.self) { movie in
                        VStack(alignment: .leading) {
                            Text(movie.title)
                        }
                    }
                    .onDelete(perform: { offsets in
                        let movieToDelete = movies[offsets.first ?? 0]
                        modelContext.delete(movieToDelete)
                    })
                }
            }
        }
    }
}


#Preview {
    WatchedMoviesList()
}
