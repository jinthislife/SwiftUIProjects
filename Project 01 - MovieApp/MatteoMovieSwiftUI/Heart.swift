//
//  Heart.swift
//  MatteoMovieSwiftUI
//
//  Created by Jin Lee on 29/6/20.
//  Copyright © 2020 Jin Lee. All rights reserved.
//

import SwiftUI

struct Heart: View {
    var isFilled: Bool;
    var body: some View {
        Image(systemName: isFilled ? "heart.fill": "heart")
            .foregroundColor(isFilled ? .red : .secondary)
    }
}

struct HeartSymbol_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Heart(isFilled: true)
            Heart(isFilled: false)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
