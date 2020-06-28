//
//  Product.swift
//  PlusMinusOne
//
//  Created by Hatice Ecevit on 27.06.2020.
//  Copyright © 2020 Hatice Ecevit. All rights reserved.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let name: String
    let desc: String
    let image: String
    var price: Price
    
    init() {
        id = 0
        name = "Placeholder"
        desc = "Placeholder"
        image = "https://dummyimage.com/450x300/4a4a4a/26d6a1"
        price = Price()
    }
}
