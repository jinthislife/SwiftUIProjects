//
//  MainView.swift
//  MatteoMovieSwiftUI
//
//  Created by Jin Lee on 29/6/20.
//  Copyright © 2020 Jin Lee. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @State var movies: [Movie] = TestData.movies
    
    var body: some View {
        TabView {
            NavigationView {
                MoviesView(movies: $movies, showOnlyFavorites: false)
            }
            .tabItem {
                Image(systemName: "list.bullet")
                    .font(.system(size: 26))
                Text("All movies")
            }
            NavigationView {
                MoviesView(movies: $movies, showOnlyFavorites: true)
            }
            .tabItem {
                Image(systemName: "heart")
                Text("Favorites")
            }
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
