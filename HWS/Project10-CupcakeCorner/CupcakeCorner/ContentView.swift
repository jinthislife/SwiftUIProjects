//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Jin Lee on 10/8/20.
//  Copyright © 2020 Jin Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.s.type) {
                        ForEach(0..<Order.types.count, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $order.s.quantity, in: 3...20) {
                        Text("Number of cakes: \(order.s.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $order.s.specialRequestEnabled.animation()) {
                        Text("Any special requests?")
                    }
                    
                    if order.s.specialRequestEnabled {
                        Toggle(isOn: $order.s.extraFrosting) {
                            Text("Add extra frosting")
                        }
                        
                        Toggle(isOn: $order.s.addSprinkles) {
                            Text("Add extra sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(order: order)) {
                        Text("Delivery details")
                    }
                }
            }
            .navigationBarTitle("Cupcake Corner")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
