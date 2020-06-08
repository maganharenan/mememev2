//
//  ContentView.swift
//  MemeMeV2
//
//  Created by Renan Maganha on 26/05/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI
import Combine

struct HomeView: View {
    @State var selection = 1
    @State var showMemeGenerator = false
    @State var showControllers = true

    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            if !showMemeGenerator {
                VStack(spacing: 0) {
                    if selection == 1 {
                        SentMemesListView(showMemeGenerator: $showMemeGenerator)
                    } else {
                        SentMemesGridView(showControllers: $showControllers, showMemeGenerator: $showMemeGenerator)
                    }
                    
                    if showControllers {
                        CustomTabBar(selection: $selection, showMemeGenerator: $showMemeGenerator)
                    }
                }
            }
            
            MemeGeneratorView(showMemeGenerator: $showMemeGenerator)
                .offset(y: showMemeGenerator ? 0 : 1000 )
                .animation(.easeIn)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct CustomTabBar: View {
    @Binding var selection: Int
    @Binding var showMemeGenerator: Bool
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    CustomTabBarItem(iconName: "list.bullet", label: "", selection: $selection, tag: 1)
                    CustomTabBarItem(iconName: "square.grid.2x2", label: "", selection: $selection, tag: 2)
                }
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(BackgroundBarStyle(fx: UIBlurEffect(style: .dark)).opacity(0.95).edgesIgnoringSafeArea(.bottom).edgesIgnoringSafeArea(.horizontal))
            }
        }
    }
}

struct CustomTabBarItem: View {
    let iconName: String
    let label: String
    let selection: Binding<Int>
    let tag: Int
    
    var body: some View {
        VStack {
            Image(systemName: iconName)
                .frame(minWidth: 25, minHeight: 25)
        }
        .padding([.top, .bottom], 5)
        .foregroundColor(fgColor())
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture {
            self.selection.wrappedValue = self.tag
        }
    }
    
    private func fgColor() -> Color {
        return selection.wrappedValue == tag ? Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) : Color(UIColor.systemGray)
    }
}

struct BackgroundBarStyle: UIViewRepresentable {
    var fx: UIVisualEffect?
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView {
        UIVisualEffectView()
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) {
        uiView.effect = fx
    }
}
