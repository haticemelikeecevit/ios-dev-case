//
//  ContentView.swift
//  PlusMinusOne
//
//  Created by Hatice Ecevit on 27.06.2020.
//  Copyright © 2020 Hatice Ecevit. All rights reserved.
//

import SwiftUI
import KingfisherSwiftUI

struct ProductDetailView: View {
    @State private var time: Int = 60
    @State private var product: Product = Bundle.main.decode(Product.self, from: "product.json")
    @State private var social: Social = Bundle.main.decode(Social.self, from: "social.json")
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack() {
            KFImage(URL(string: product.image))
                .resizable()
                .scaledToFit()
            HStack {
                VStack(alignment: .leading) {
                    TitleView(product: $product)
                    RatingView(commentCounts: $social.commentCounts)
                        .onReceive(timer) { _ in
                            if self.time > 0 {
                                self.time -= 1
                            } else {
                                self.social = Bundle.main.decode(Social.self, from: "social.json")
                                self.time = 60
                            }
                    }
                    .padding(.bottom, 4)
                    PriceView(price: $product.price)
                }
                .padding(.leading)
                Spacer()
                VStack {
                    LikeView(social: $social)
                    RingView(size: CGSize(width: 40, height: 40), time: $time)
                }
                .padding(.trailing)
            }
            .padding(.top)
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView()
    }
}

struct RatingView: View {
    @Binding var commentCounts: CommentCounts
    var numberOfFullStars : Int{
        Int(commentCounts.averageRating)
    }
    var hasHalfStar: Bool {
        Int(commentCounts.averageRating * 10) % 10 != 0
    }
    var numberOfUnfilledStars: Int {
        hasHalfStar ? (4 - numberOfFullStars) : (5 - numberOfFullStars)
    }
    
    var body: some View {
        HStack {
            Text(String(commentCounts.averageRating))
                .font(.system(size: 12, weight: .bold))
            ForEach(0 ..< numberOfFullStars) { item in
                Image(systemName: "star.fill")
            }
            if hasHalfStar {
                Image(systemName: "star.lefthalf.fill")
            }
            ForEach(0 ..< numberOfUnfilledStars) { item in
                Image(systemName: "star")
            }
            
            Text("(\(commentCounts.memberCommentsCount + commentCounts.anonymousCommentsCount) Yorum)")
                .font(.system(size: 15, weight: .regular))
        }
        .font(.system(size: 15, weight: .bold))
        .foregroundColor(.orange)
    }
}

struct TitleView: View {
    @Binding var product: Product
    var body: some View {
        HStack {
            Text(product.name)
                .bold()
            Text(product.desc)
                .foregroundColor(Color.secondary)
                .font(.footnote)
        }
    }
}

struct PriceView: View {
    @Binding var price: Price
    var body: some View {
        HStack {
            Text(String(price.value))
            Text(price.currency)
                .padding(.leading, -8)
        }
        .font(.system(size: 20, weight: .bold))
    }
}


struct LikeView: View {
    @Binding var social: Social
    var body: some View {
        Group {
            Image(systemName: "heart.fill").foregroundColor(Color.red)
            Text(String(social.likeCount))
                .font(.subheadline)
                
                .foregroundColor(.secondary)
        }
    }
}
