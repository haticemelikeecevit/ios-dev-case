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
}
