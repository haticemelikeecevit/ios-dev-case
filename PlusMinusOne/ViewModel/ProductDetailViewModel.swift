//
//  ProductDetailViewModel.swift
//  PlusMinusOne
//
//  Created by Hatice Ecevit on 27.06.2020.
//  Copyright © 2020 Hatice Ecevit. All rights reserved.
//

import Foundation
import Combine

class ProductDetailViewModel: ObservableObject {

    @Published var product: Product
    @Published var social: Social
    
    init() {
        social = Bundle.main.decode(Social.self, from: "social-data.json")
        product = Bundle.main.decode(Product.self, from: "product.json")
    }

    
    func fetchSocial() {
        social = Bundle.main.decode(Social.self, from: "social-data.json")
    }
    
}
