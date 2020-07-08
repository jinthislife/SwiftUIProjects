//
//  ContentView.swift
//  MatteoMovieSwiftUI
//
//  Created by Jin Lee on 29/6/20.
//  Copyright © 2020 Jin Lee. All rights reserved.
//

import SwiftUI

struct Row: View {
    let movie: Movie
    var body: some View {
        HStack(spacing: 24.0) {
            Image(movie.poster)
                .resizable()
                .frame(width: 70, height: 100)
                .shadow(color: .gray, radius: 10.0, x: 4.0, y: 4.0)
            VStack(alignment: .leading, spacing: 4.0) {
                HStack {
                    Text(movie.title)
                        .font(.headline)
                    Spacer()
//                    if movie.isFavorite {
                        Heart(isFilled: true)
//                    }
                }
                Text(movie.director)
                    .font(.subheadline)
                Group {
                    Text(movie.genre)
                    Text(movie.runtime)
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}

struct Row_Previews: PreviewProvider {
    static var previews: some View {
        Row(movie: TestData.movies[0])
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
