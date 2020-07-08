//
//  DetailsView.swift
//  MatteoMovieSwiftUI
//
//  Created by Jin Lee on 29/6/20.
//  Copyright © 2020 Jin Lee. All rights reserved.
//

import SwiftUI

struct DetailsView: View {
    @Binding var movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 36.0) {
            HStack(alignment: .top, spacing: 24.0) {
                Image(movie.poster)
                    .resizable()
                    .frame(width: 150.0, height: 237.0)
                    .shadow(color: .gray, radius: 10.0, x: 5.0, y: 5.0)
                SideInfo(movie: $movie)
            }
            BottomInfo(movie: movie)
            Spacer()
        }
        .padding(.top, 18)
        .padding(.horizontal, 20)
        .navigationBarTitle(movie.title)
        
    }
    
}

struct BottomInfo: View {
    let movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            VStack(alignment: .leading)  {
                Text("Directed by:")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(movie.director)
                    .font(.headline)
            }
            
            VStack(alignment: .leading) {
                Text("Actors:")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(movie.actors)
                    .font(.headline)
            }
            Divider()
            Text(movie.plot).font(.body)
        }
    }
}

struct SideInfo: View {
    @Binding var movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 8.0) {
                    Text(movie.year + " ," + movie.country)
                    Text(movie.genre)
                    Text(movie.runtime)
                }
                .font(.callout)
                .foregroundColor(.secondary)
                .padding(.top, 6)
                Spacer()
                Button(action: { self.movie.isFavorite.toggle() }) {
                    Heart(isFilled: movie.isFavorite)
                        .font(.title)
                }
            }
            Text(movie.awards)
                .font(.callout)
                .foregroundColor(.secondary)
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static let movie = TestData.movies[0]
    static var previews: some View {
        Group {
            DetailsView(movie: .constant(movie))
            Group {
                BottomInfo(movie: movie)
                SideInfo(movie: .constant(movie))
            }
        }
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
