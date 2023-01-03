//
//  Home.swift
//  MetaBall
//
//  Created by Balaji on 22/09/22.
//

import SwiftUI

struct MetaBallSingle: View {
    // MARK: Animation Properties
    @State var dragOffset: CGSize = .zero
    
    var body: some View {
        VStack{
            SingleMetaBall()
        }
        .background(Color.black)
        .frame(width: 414, height: 800)
    }
    
    // MARK: Single MetaBall Animation
    @ViewBuilder
    func SingleMetaBall()->some View{
        // MARK: If You Need Gradient Color, Then Use Mask
        Rectangle()
            .fill(.linearGradient(colors: [Color("Gradient1"),Color("Gradient2")], startPoint: .top, endPoint: .bottom))
            .mask {
                // MARK: For More Check out my Morphing Shapes In SwiftUI Video
                // Link in the description
                Canvas { context, size in
                    // MARK: Adding Filters
                    // Change here If you need Custom Color
                    context.addFilter(.alphaThreshold(min: 0.5,color: .yellow))
                    // MARK: This blur Radius determines the amount of elasticity between two elements
                    context.addFilter(.blur(radius: 35))
                    
                    // MARK: Drawing Layer
                    context.drawLayer { ctx in
                        // MARK: Placing Symbols
                        for index in [1,2]{
                            if let resolvedView = context.resolveSymbol(id: index){
                                ctx.draw(resolvedView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                            }
                        }
                    }
                } symbols: {
                    Ball()
                        .tag(1)
                    
                    Ball(offset: dragOffset)
                        .tag(2)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        dragOffset = value.translation
                    }).onEnded({ _ in
                        withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)){
                            dragOffset = .zero
                        }
                    })
            )
    }
    
    @ViewBuilder
    func Ball(offset: CGSize = .zero)->some View{
        Circle()
            .fill(.white)
            .frame(width: 150, height: 150)
            .offset(offset)
    }
}

struct MetaBallSingle_Previews: PreviewProvider {
    static var previews: some View {
        MetaBallSingle()
    }
}
