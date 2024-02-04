//
//  ChatBubble.swift
//  HealthyMind
//
//  Created by Eva Herson on 01/02/2024.
//

import Foundation
import SwiftUI

struct ChatBubbleTestView: View {
    
    var width : CGFloat
    var height : CGFloat
    var color : Color
    
    enum Direction {
        case left
        case right
    }
    
    let direction : Direction
    
    var body: some View {
        let point1 = direction == ChatBubbleTestView.Direction.left ? width/10 : 9*width/10
        let point2 = direction == ChatBubbleTestView.Direction.left ? (width/5) : (4*width/5)
        
        ZStack {
            Rectangle()
                .cornerRadius(20)
                .frame(width: width, height: height)
                .foregroundColor(color)
            
            Path { p in
                p.move(to: CGPoint(x : point1, y : height))
                p.addLine(to: CGPoint( x : point1, y : height + 30))
                p.addLine(to: CGPoint( x : point2, y : height))
                p.addLine(to: CGPoint(x : point1, y : height))
            }
            .fill(color)
        }
        
        .frame(width: width, height: height)

        
    }
}

#Preview {
    ChatBubbleTestView(width : 300, height : 200, color: Color("font2"), direction: ChatBubbleTestView.Direction.left)
}

