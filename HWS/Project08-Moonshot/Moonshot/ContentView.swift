//
//  ContentView.swift
//  Moonshot
//
//  Created by Jin Lee on 9/8/20.
//  Copyright © 2020 Jin Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    Image(mission.image)
                        .resizable()
                        //                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                    
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(mission.formattedLaunchDate)
                    }
                }
                
            }
            .navigationBarTitle("Moonshot")
        }
    }
    //    var body: some View {
    //        VStack {
    //
    //            GeometryReader { geo in
    //                Image("IMG_0522")
    //                    .resizable()
    //                    .aspectRatio(contentMode: .fill)
    //                    .frame(width: geo.size.width)
    ////                    .clipped()
    //            }
    //        }
    //    }
    
    //    var body: some View {
    //        ScrollView(.vertical) {
    //            VStack(spacing: 10) {
    //                ForEach(0..<100) {
    //                    Text("Item \($0)")
    //                        .font(.title)
    //                }
    //
    //            }
    //            .frame(maxWidth: .infinity)
    //        }
    //
    //    }
    
    //    var body: some View {
    //        NavigationView {
    //            List(0..<100) { row in
    //                NavigationLink(destination: Text("Detail \(row)")) {
    //                    Text("Row \(row)")
    //                }
    //            }
    //        .navigationBarTitle("SWIFT UI")
    //
    //        }
    //    }
    
    //    var body: some View {
    //        Button("Decode Json") {
    //            let input = """
    //            {
    //                "name": "Taylor Swift",
    //                "address": {
    //                    "street": "555, Taylor Swift Avenue",
    //                    "city": "Nashville"
    //                }
    //            }
    //            """
    //
    //            let data = Data(input.utf8)
    //
    //            let decoder = JSONDecoder()
    //            if let user = try? decoder.decode(User.self, from: data) {
    //                print(user.address.street)
    //            }
    //
    //        }
    //    }
    
}

struct User: Decodable {
    let name: String
    let address: Address
}

struct Address: Decodable {
    let street: String
    let city: String
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
