//
//  MoviePosterView.swift
//  MoviesCatalog
//
//  Created by avz on 23/08/24.
//

import SwiftUI

struct MoviePosterView: View {
    let imageURL: URL?
    let relativeFrameSize: CGFloat
    
    var body: some View {
        ZStack {
            AsyncImage(url: imageURL) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                } else if phase.error != nil {
                    Color.gray
                } else {
                    ProgressView()
                }
            }
        }
        .scaledToFit()
        .containerRelativeFrame(.horizontal) { size, axis in
            size * relativeFrameSize
        }
    }
}

#Preview {
    MoviePosterView(imageURL: URL(string: "https://image.tmdb.org/t/p/w500/1E5baAaEse26fej7uHcjOgEE2t2.jpg")!, relativeFrameSize: 0.5)
}
