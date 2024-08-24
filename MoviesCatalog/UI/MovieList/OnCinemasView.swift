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
        ZStack {
            Color.appBackground
                .ignoresSafeArea()
        VStack(alignment: .leading, spacing: 0) {
            Group {
                HStack {
                    Text("In Theaters now")
                        .font(.largeTitle)
                        .fontWeight(.black)
                        .padding([.bottom, .leading])
                        .foregroundColor(.black)
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width)
//                Rectangle()
//                    .fill(.foreground)
//                    .frame(height: 1)
            }
            .background(Color.ratingView)
            
            
            if !viewModel.movies.isEmpty {
                ScrollView {
                    ForEach(viewModel.movies, id: \.self) { movie in
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
    }
    }
}

#Preview {
    OnCinemasView()
}
