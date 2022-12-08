//
//  Order.swift
//  CupcakeCorner
//
//  Created by Arthur Sh on 07.12.2022.
//

import SwiftUI


class Order: ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, AddSprinkles, name, address, city, zip
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Blueberry"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequest = false {
        didSet {
            if specialRequest == false {
                extraFrosting = false
                extraSpinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var extraSpinkles = false
    
    
    @Published var name = ""
    @Published var address = ""
    @Published var city = ""
    @Published var zip = ""
    
    var isValidAddress: Bool {
        if name.isEmpty || address.isEmpty || city.isEmpty || zip.isEmpty{
            return false
        } else if name.hasPrefix(" ") || name.hasSuffix(" ") || address.hasPrefix(" ") || address.hasSuffix(" ") || city.hasPrefix(" ") || city.hasSuffix(" ") || zip.hasPrefix(" ") || zip.hasSuffix(" "){
            return false
        }
        return true
    }
    
    var totalCost: Double {
        // 2$ per cake
        var cost = Double(quantity) * 2
        
        // more complicated cakes cost more
        cost += Double(type) / 2
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if extraSpinkles {
            cost += Double(quantity) / 2
        }
        return cost
    }
    // init for making instances with empty ()
    init() { }
    
    // archiving data
    func encode(to encoder: Encoder) throws {
        var container =  encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(extraSpinkles, forKey: .AddSprinkles)
        try container.encode(name, forKey: .name)
        try container.encode(address, forKey: .address)
        try container.encode(city, forKey: .city)
        try container.encode(zip, forKey: .zip)
    }
    
    // unarchiving data
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
         type = try container.decode(Int.self, forKey: .type)
         quantity = try container.decode(Int.self, forKey: .quantity)
         extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
         extraSpinkles = try container.decode(Bool.self, forKey: .AddSprinkles)
         name = try container.decode(String.self, forKey: .name)
         address = try container.decode(String.self, forKey: .address)
         city = try container.decode(String.self, forKey: .city)
         zip = try container.decode(String.self, forKey: .zip)
    }
    
}
