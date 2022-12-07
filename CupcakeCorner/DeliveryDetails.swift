//
//  DeliveryDetails.swift
//  CupcakeCorner
//
//  Created by Arthur Sh on 07.12.2022.
//

import SwiftUI

struct DeliveryDetails: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form{
            Section{
                TextField("Name", text: $order.name)
                TextField("Address", text: $order.address)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            
            Section{
                NavigationLink{
                    CheckOutView(order: order)
                }label: {
                    Text("Check Out")
                }
            }
            .disabled(order.isValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DeliveryDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            DeliveryDetails(order: Order())
        }
    }
}
