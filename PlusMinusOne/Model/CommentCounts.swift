//
//  CommentCounts.swift
//  PlusMinusOne
//
//  Created by Hatice Ecevit on 27.06.2020.
//  Copyright © 2020 Hatice Ecevit. All rights reserved.
//

import Foundation

struct CommentCounts: Decodable {
    let averageRating: Double
    let anonymousCommentsCount: Int
    let memberCommentsCount: Int
    
    init() {
        averageRating = 0
        anonymousCommentsCount = 0
        memberCommentsCount = 0
    }
}
