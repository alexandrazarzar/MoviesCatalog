//
//  HeaderView.swift
//  MoviesCatalog
//
//  Created by avz on 26/08/24.
//

import SwiftUI

struct HeaderView: View {
    let headerText: String
    
    var body: some View {
        HStack {
            Label(headerText, systemImage: "popcorn")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding([.bottom, .leading])
            .foregroundColor(.white)
            Spacer()
        }
        .frame(maxWidth: UIScreen.main.bounds.width)
        .background(Color.cinemaRed)
    }
}
