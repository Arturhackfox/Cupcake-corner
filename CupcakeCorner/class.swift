//
//  class.swift
//  CupcakeCorner
//
//  Created by Arthur Sh on 06.12.2022.
//

import Foundation


class User: Codable, ObservableObject{
    
    enum CodingKeys: CodingKey{
        case name
    }
    
    var name = "Archi"
 
    required init(from decoder: Decoder) throws {
       guard let container = decoder.container(keyedBy: CodingKeys.self)
    }
    
    
}
