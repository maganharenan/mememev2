//
//  Modifiers.swift
//  MemeMeV2
//
//  Created by Renan Maganha on 04/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI

//MARK: PopUps
struct PopUpTextTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.headline)
    }
}

struct PopUpTextSubTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.footnote)
    }
}

struct PopUpSlider: ViewModifier {
    func body(content: Content) -> some View {
        content
            .accentColor(.white)
            .frame(width: 200)
    }
}

struct PopUpAnchor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(Color(#colorLiteral(red: 0.1856770865, green: 0.2010366391, blue: 0.2233502538, alpha: 1)))
            .frame(width: 20, height: 20)
            .rotationEffect(.degrees(45))
    }
}

struct PopUpContainer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 300, height: 150)
            .background(BackgroundBarStyle(fx: UIBlurEffect(style: .dark)).opacity(0.8))
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .offset(y: 22.5)
    }
}

//MARK: ToolBar/TabBar
struct ButtonsLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.clear)
            .contentShape(Rectangle())
            .frame(width: 30, height: 30)
    }
}
