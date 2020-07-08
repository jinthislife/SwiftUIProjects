//
//  MoviesView.swift
//  MatteoMovieSwiftUI
//
//  Created by Jin Lee on 29/6/20.
//  Copyright © 2020 Jin Lee. All rights reserved.
//

import SwiftUI

struct MoviesView: View {
    @Binding var movies: [Movie]
    let showOnlyFavorites: Bool
    
    @State private var deletionOffsets: IndexSet = []
    @State private var isShowingDeleteConfirmation: Bool = false

    var body: some View {
        List {
            ForEach(displayedMovies, id: \.title) { movie in
                NavigationLink(destination: DetailsView(movie: self.$movies[self.index(for: movie)])) {
                    Row(movie: movie)
                }
            }
            .onMove { source, destination in
                self.movies.move(fromOffsets: source, toOffset: destination)
            }
            .onDelete { offsets in
                self.deletionOffsets = offsets
                self.isShowingDeleteConfirmation = true
            }
        }
        .navigationBarTitle("All movies")
        .navigationBarItems(trailing: showOnlyFavorites ? nil :EditButton())
        .actionSheet(isPresented: $isShowingDeleteConfirmation) {
            ActionSheet(title: Text("Are you sure"), message: Text("The action is not reversible"), buttons: [.destructive(Text("Delete Movie"), action: { self.movies.remove(atOffsets: self.deletionOffsets) }), .cancel()
            ])
        }

    }
}

private extension MoviesView {
    var displayedMovies: [Movie] {
        showOnlyFavorites
            ? movies.filter { $0.isFavorite }
            : movies
    }
    
    func index(for movie: Movie) -> Int {
        movies.firstIndex(where: { $0.title == movie.title })!
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MoviesView(movies: .constant(TestData.movies), showOnlyFavorites: false)
        }
    }
}
