//
//  SentMemesGridView.swift
//  MemeMeV2
//
//  Created by Renan Maganha on 30/05/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI
import Combine

struct SentMemesGridView: View {
    @EnvironmentObject var orientationInfo: OrientationInfo
    @State var showDelete = false
    @Binding var showControllers: Bool
    @Binding var showMemeGenerator: Bool
    
    var body: some View {
        ZStack {

            NavigationView {
    
                ZStack {
                    Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                        .edgesIgnoringSafeArea(.all)

                    if orientationInfo.orientation == .landscape {
                        GridStructure(showControllers: $showControllers, showDelete: $showDelete)
                    } else {
                        GridStructure(showControllers: $showControllers, showDelete: $showDelete)
                    }
                   
                }
                .background(Color.black.edgesIgnoringSafeArea(.all))
                .navigationBarTitle(Text("Sent Memes"), displayMode: .inline)
                .navigationBarItems(
                    leading:
                    Button(action: {
                        self.showDelete.toggle()
                    }, label: {
                        Text("Edit")
                        .foregroundColor(Color(#colorLiteral(red: 0.959558785, green: 0.6947034597, blue: 0, alpha: 1)))
                    }),
                    trailing: Button(action: {
                        self.showMemeGenerator.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundColor(Color(#colorLiteral(red: 0.9607843137, green: 0.6941176471, blue: 0, alpha: 1)))
                    })
                )
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct GridStructure: View {
    @EnvironmentObject var orientationInfo: OrientationInfo
    @ObservedObject var memeStore = MemeStore()
    @Binding var showControllers: Bool
    @Binding var showDelete: Bool
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                //Prints the grid rows
                ForEach(0..<self.defineRowsNumber(items: memeStore.memes.count, columns: self.defineColumnsNumber())) { row in
                    HStack {
                        //Prints the grid columns
                        ForEach(0..<self.defineColumnsNumber()) { col in
                            //Verifies if the current index is minor than memes array count
                            if self.getCurrentIndex(row: row, col: col) < self.memeStore.memes.count {
                                //Prints the thumbnail of the memed image
                                NavigationLink(destination: ImageDetailView(showControllers: self.$showControllers, image: self.memeStore.memes[self.getCurrentIndex(row: row, col: col)].memedImage)) {
                                    GridItem(memedImage: self.memeStore.memes[row * self.defineColumnsNumber() + col].memedImage, size: self.defineThumbnailSize(), showDelete: self.$showDelete)
                                }
                            } else {
                                //Prints an empty space to compose the grid
                                Rectangle()
                                    .frame(width: self.defineThumbnailSize(), height: self.defineThumbnailSize())
                                    .foregroundColor(.clear)
                            }
                        }
                        
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 10)
        }
        .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)).edgesIgnoringSafeArea(.all))
    }
}

struct GridItem: View {
    var memedImage: UIImage
    var size: CGFloat
    @Binding var showDelete: Bool
    
    var body: some View {
        Image(uiImage: memedImage)
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size, height: size)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
            .overlay(
                //Button Delete
                HStack {
                    Spacer()
                    
                    VStack {
                        Button(action: {

                        }, label: {
                            Image(systemName: "trash.circle.fill")
                                .foregroundColor(.white)
                                .imageScale(.large)
                                .frame(maxWidth: 44, maxHeight: .infinity)
                                .background(Color.red)
                        })
                    }
                    .animation(.easeIn)
                    .offset(x: self.showDelete ? 0 : 100)
                    
                }.frame(width: size, height: size)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                
        )
    }
}
