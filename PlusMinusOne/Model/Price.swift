//
//  Price.swift
//  PlusMinusOne
//
//  Created by Hatice Ecevit on 27.06.2020.
//  Copyright © 2020 Hatice Ecevit. All rights reserved.
//

import Foundation

struct Price: Decodable {
    let value: Double
    let currency: String
    
    init() {
        value = 0
        currency = "$"
    }
}
