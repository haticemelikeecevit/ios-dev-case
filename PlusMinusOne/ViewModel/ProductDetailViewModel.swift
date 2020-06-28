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
    @Published var showError: Bool
    
    init() {
        showError = false
        do {
            social = try Bundle.main.decode(Social.self, from: "social-data.json")
            product = try Bundle.main.decode(Product.self, from: "product.json")
        } catch {
            social = Social()
            product = Product()
            showError = true
        }
    }

    
    func fetchSocial() {
        showError = false
        do {
            social = try Bundle.main.decode(Social.self, from: "social-data.json")
        } catch {
            social = Social()
            showError = true
        }
    }
    
}
