//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Jin Lee on 10/8/20.
//  Copyright © 2020 Jin Lee. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.s.name)
                TextField("Street Address", text: $order.s.streetAddress)
                TextField("City", text: $order.s.city)
                TextField("Zip", text: $order.s.zip)
            }
            
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("Checkout")
                }
            }
            .disabled(order.s.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery datails", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
