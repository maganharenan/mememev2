//
//  PopUpMenuItem.swift
//  MemeMeV1
//
//  Created by Renan Maganha on 17/05/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI

struct TextFieldPropertiesItem: View {
    @Binding var positionX: CGFloat
    @Binding var topTextFontSize: CGFloat
    @Binding var bottomTextFontSize: CGFloat
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .modifier(PopUpAnchor())
                .offset(x: positionX, y: -50.5)
            
            VStack {
                Text("Top Text:")
                    .modifier(PopUpTextTitle())

                HStack {
                    Text("Size:")
                        .modifier(PopUpTextSubTitle())
                    
                    Spacer()
                    
                    Slider(value: $topTextFontSize, in: 10...100, step: 0.1)
                        .modifier(PopUpSlider())
                }
                .padding(.horizontal)
                
                Text("Bottom Text:")
                    .modifier(PopUpTextTitle())
                
                HStack {
                    Text("Size:")
                        .modifier(PopUpTextSubTitle())
                    
                    Spacer()
                    
                    Slider(value: $bottomTextFontSize, in: 10...100, step: 0.1)
                        .modifier(PopUpSlider())
                }
                .padding(.horizontal)
                
                
            }
            .modifier(PopUpContainer())
        }
    }
}

struct TextAttributesView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldPropertiesItem(positionX: .constant(0), topTextFontSize: .constant(30), bottomTextFontSize: .constant(30))
    }
}
