//
//  Home.swift
//  MetaBall
//
//  Created by Balaji on 22/09/22.
//

import SwiftUI

struct MetaBallClubbed: View {
    // MARK: Animation Properties
    @State var startAnimation: Bool = false
    
    var body: some View {
        VStack{
            ClubbedView()
        }
        .background(Color.black)
        .frame(width: 414, height: 800)
    }
    
    // MARK: Clubbed One
    // Like Blob Background Animation
    @ViewBuilder
    func ClubbedView()->some View{
        Rectangle()
            .fill(.linearGradient(colors: [Color("Gradient1"),Color("Gradient2")], startPoint: .top, endPoint: .bottom))
            .mask({
                // It's Quite the Same With the Addition of TimelineView
                // MARK: Timing Is Your Wish for how Long The Animation needs to be Changed
                TimelineView(.animation(minimumInterval: 3.6, paused: false)) { _ in
                    Canvas { context, size in
                        // MARK: Adding Filters
                        // Change here If you need Custom Color
                        context.addFilter(.alphaThreshold(min: 0.5,color: .white))
                        // MARK: This blur Radius determines the amount of elasticity between two elements
                        context.addFilter(.blur(radius: 30))
                        
                        // MARK: Drawing Layer
                        context.drawLayer { ctx in
                            // MARK: Placing Symbols
                            for index in 1...15{
                                if let resolvedView = context.resolveSymbol(id: index){
                                    ctx.draw(resolvedView, at: CGPoint(x: size.width / 2, y: size.height / 2))
                                }
                            }
                        }
                    } symbols: {
                        // MARK: Count is your wish
                        ForEach(1...15,id: \.self){index in
                            // MARK: Generating Custom Offset For Each Time
                            // Thus It will be at random places and clubbed with each other
                            let offset = (startAnimation ? CGSize(width: .random(in: -180...180), height: .random(in: -240...240)) : .zero)
                            ClubbedRoundedRectangle(offset: offset)
                                .tag(index)
                        }
                    }
                }
            })
            .contentShape(Rectangle())
            .onTapGesture {
                startAnimation.toggle()
            }
    }
    
    @ViewBuilder
    func ClubbedRoundedRectangle(offset: CGSize)->some View{
        RoundedRectangle(cornerRadius: 30, style: .continuous)
            .fill(.white)
            .frame(width: 120, height: 120)
            .offset(offset)
            // MARK: Adding Animation[Less Than TimelineView Refresh Rate]
            .animation(.easeInOut(duration: 4), value: offset)
    }
}

struct MetaBallClubbed_Previews: PreviewProvider {
    static var previews: some View {
        MetaBallClubbed()
    }
}
