//
//  ContentView.swift
//  PlusMinusOne
//
//  Created by Hatice Ecevit on 27.06.2020.
//  Copyright © 2020 Hatice Ecevit. All rights reserved.
//

import SwiftUI
import Combine
import KingfisherSwiftUI

struct ProductDetailView: View {
    @State private var time: Int = 60
    
    @ObservedObject var viewModel: ProductDetailViewModel
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack() {
            KFImage(URL(string: viewModel.product.image))
                .resizable()
                .scaledToFit()
            HStack {
                VStack(alignment: .leading) {
                    TitleView(product: $viewModel.product)
                    RatingView(commentCounts: $viewModel.social.commentCounts)
                        .onReceive(timer) { _ in
                            if self.time > 0 {
                                self.time -= 1
                            } else {
                                self.viewModel.fetchSocial()
                                self.time = 60
                            }
                    }
                    .padding(.bottom, 4)
                    PriceView(price: $viewModel.product.price)
                }
                .padding(.leading)
                Spacer()
                VStack {
                    LikeView(social: $viewModel.social)
                    RingView(size: CGSize(width: 32, height: 32), time: $time)
                }
                .padding(.trailing)
            }
            .padding(.top)
            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
        .alert(isPresented: $viewModel.showError) {
                   Alert(title: Text("Couldn' read from file!"), message: Text("The JSON file might be missing or the contents may be incorrect!"), dismissButton: .default(Text("OK")))
               }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(viewModel: ProductDetailViewModel())
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
