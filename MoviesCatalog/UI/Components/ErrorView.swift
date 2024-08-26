//
//  ErrorView.swift
//  MoviesCatalog
//
//  Created by avz on 26/08/24.
//

import SwiftUI

struct ErrorView: View {
    let errorDescription: String
    
    init(_ errorDescription: String) {
        self.errorDescription = errorDescription
    }
    
    var body: some View {
        VStack {
            Image(systemName: Constants.Image.error)
                .foregroundColor(.cinemaRed)
                .font(.system(size: Constants.Numbers.errorImageSize))
                .padding(.bottom)
            Text(errorDescription)
                .font(.headline)
        }
    }
    
    enum Constants {
        enum Numbers {
            static let errorImageSize: CGFloat = 70
        }
        
        enum Image {
            static let error = "exclamationmark.triangle.fill"
        }
    }
}

#Preview {
    ErrorView("This is an error")
}
