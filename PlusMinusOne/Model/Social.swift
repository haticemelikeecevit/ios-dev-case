//
//  Social.swift
//  PlusMinusOne
//
//  Created by Hatice Ecevit on 27.06.2020.
//  Copyright © 2020 Hatice Ecevit. All rights reserved.
//

import Foundation

struct Social: Decodable {
    let likeCount: Int
    var commentCounts: CommentCounts
    
    init() {
        likeCount = 0
        commentCounts = CommentCounts()
    }
}
