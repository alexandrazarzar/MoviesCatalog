//
//  ContentView.swift
//  MoviesCatalog
//
//  Created by avz on 26/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            TabView {
                MoviesListView(viewModel: MoviesListViewModel())
                    .tabItem {
                        Label("All", systemImage: "list.star")
                    }

                WatchedMoviesList()
                    .tabItem {
                        Label("Journal", systemImage: "calendar")
                    }
            }
            .modelContainer(for: WatchedMovie.self)
            .tint(.cinemaRed)
        }
}

#Preview {
    ContentView()
}
