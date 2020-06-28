//
//  RingView.swift
//  PlusMinusOne
//
//  Created by Hatice Ecevit on 27.06.2020.
//  Copyright © 2020 Hatice Ecevit. All rights reserved.
//

import SwiftUI

struct RingView: View {
    var color: Color = .red
    var size: CGSize = CGSize(width: 80, height: 80)
    
    @Binding var time: Int
    
    var multiplier: CGFloat {
        size.width / 44
    }
    
    var percentage: CGFloat {
        1 - CGFloat(time) / 60
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.black.opacity(0.1), style: StrokeStyle(lineWidth: 5 * multiplier))
                .frame(width: size.width, height: size.height)
            
            Circle()
                .trim(from: percentage, to: 1)
                .stroke(Color.orange, style: StrokeStyle(lineWidth: 5 * multiplier, lineCap: .round, miterLimit: .infinity))
                .rotationEffect(.degrees(90))
                .rotation3DEffect(.degrees(180), axis: (x: 1, y: 0, z: 0) )
            .frame(width: size.width, height: size.height)
            
            Text(String(time))
                .foregroundColor(.orange)
                .font(.system(size: 12 * multiplier, weight: .bold))
        }
        
    }
}

struct RingView_Previews: PreviewProvider {
    static var previews: some View {
        RingView(time: .constant(40))
    }
}
