//
//  TextFieldPositionItem.swift
//  MemeMeV1
//
//  Created by Renan Maganha on 17/05/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI

struct TextFieldPositionItem: View {
    @Binding var positionX: CGFloat
    @Binding var topTextPosition: CGFloat
    @Binding var bottomTextPosition: CGFloat
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .modifier(PopUpAnchor())
                .offset(x: positionX, y: -50.5)
            
            VStack {
                
                Text("Top Text:")
                    .modifier(PopUpTextTitle())
                
                HStack {
                    Text("Position:")
                        .modifier(PopUpTextSubTitle())
                    
                    Spacer()
                    
                    Slider(value: $topTextPosition, in: 0 ... 200, step: 0.1)
                        .modifier(PopUpSlider())
                    
                }
                .padding(.horizontal)
                
                Text("Bottom Text:")
                    .modifier(PopUpTextTitle())
                
                HStack {
                    Text("Position:")
                        .modifier(PopUpTextSubTitle())
                    
                    Spacer()
                    
                    Slider(value: $bottomTextPosition, in: -200 ... 0, step: 0.1)
                        .modifier(PopUpSlider())
                    
                }
                .padding(.horizontal)
            }
            .modifier(PopUpContainer())
        }
    }
}

struct TextFieldPositionItem_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldPositionItem(positionX: .constant(0), topTextPosition: .constant(0), bottomTextPosition: .constant(0))
    }
}
