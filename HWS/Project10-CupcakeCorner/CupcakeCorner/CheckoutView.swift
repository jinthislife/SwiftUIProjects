//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Jin Lee on 10/8/20.
//  Copyright © 2020 Jin Lee. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your total is $\(self.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("Place Order") {
                        self.placeOrder()
                    }
                    .padding()
                }
            }
        }
        .navigationBarTitle("Check out", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thank you"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func placeOrder() {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                let errorMessage = error?.localizedDescription ?? ""
                print("No data in response: \(errorMessage)")
//                DispatchQueue.main.async {
                    self.confirmationMessage = errorMessage
                    self.showingConfirmation = true
//                }
                return
            }
            
            //            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
            //                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            //            } else {
            //                print("invalid response from server")
            //            }
            
            do {
                let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
                self.confirmationMessage = "Your order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } catch {
                print(error)
            }
            
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
