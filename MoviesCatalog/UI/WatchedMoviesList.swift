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
        ZStack {
            Color.appBackground
            VStack(spacing: 0) {
                HeaderView(headerText: Constants.Text.header)
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
                .scrollContentBackground(.hidden)
            }
        }
    }
    
    enum Constants {
        enum Text {
            static let header = "My movie journal"
        }
    }
}


#Preview {
    WatchedMoviesList()
}
