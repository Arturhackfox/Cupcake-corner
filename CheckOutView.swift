//
//  CheckOutView.swift
//  CupcakeCorner
//
//  Created by Arthur Sh on 07.12.2022.
//

import SwiftUI

struct CheckOutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var isAlertShowing = false
    
    var body: some View {
        ScrollView{
            VStack{
                AsyncImage(url: URL(string: "https://www.bhg.com/thmb/EEiHl8krVv7Y7IziWNHBt_7WOC4=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/how-to-bake-how-to-make-cupcakes-hero-01-12c03f3eff374d569b0565bff7d9e597.jpg"), scale: 3){ image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 290)
                
                Text("Your total is: \(order.totalCost, format: .currency(code: "USD"))")
                
                Button("Place order"){
                    Task{
                        await placeOrder()
                    }
                }
            }
            .navigationTitle("Check out")
            .navigationBarTitleDisplayMode(.inline)
            .alert("You placed an order!", isPresented: $isAlertShowing){
                Button("Ok"){}
            } message: {
                Text(confirmationMessage)
            }
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode data")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        // Uploading data from server above
        do{
            let (data, _ ) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            
            //Adding decoded data to alert
            
            confirmationMessage = "The order for \(decodedOrder.quantity)x \(Order.types[decodedOrder.type]) cupcakes is one the way!"
            
            isAlertShowing = true
            
        } catch{
            print("Failed to upload data from server")
        }
    }
}

struct CheckOutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutView(order: Order())
    }
}
