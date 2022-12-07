//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Arthur Sh on 06.12.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var order = Order()
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Picker("Select you cake type", selection: $order.type){
                        ForEach(Order.types.indices, id: \.self){
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes: \(order.quantity)  ", value: $order.quantity, in: 1...20)
                }
                
                Section{
                    Toggle("Any special request ?", isOn: $order.specialRequest)
                    
                    if order.specialRequest {
                        Toggle("Extra sprinkles", isOn: $order.extraSpinkles)
                        Toggle("Extra frosting", isOn: $order.extraFrosting)
                    }
                    
                }
                
                Section{
                    NavigationLink{
                        DeliveryDetails(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
