//
//  TestData.swift
//  MatteoMovieSwiftUI
//
//  Created by Jin Lee on 29/6/20.
//  Copyright © 2020 Jin Lee. All rights reserved.
//

import Foundation

struct TestData {
    static var movies: [Movie] = {
        let url = Bundle.main.url(forResource: "Movies", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try! decoder.decode([Movie].self, from: data)
    }()
}
