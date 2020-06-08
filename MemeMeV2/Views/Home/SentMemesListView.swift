//
//  SentMemesListView.swift
//  MemeMeV2
//
//  Created by Renan Maganha on 26/05/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI
import Combine

struct SentMemesListView: View {
    @ObservedObject var memeStore = MemeStore()
    @Binding var showMemeGenerator: Bool
    
    var body: some View {
        NavigationView {
            List {
                ForEach(memeStore.memes, id: \.self) { meme in
                    NavigationLink(destination: Image(uiImage: meme.memedImage)) {
                        SentMemeCell(memedImage: meme.memedImage, topText: meme.topText, bottomText: meme.bottomText)
                    }
                }
                .onDelete { index in
                    self.memeStore.memes.remove(at: index.first!)
                    memesList.remove(at: index.first!)
                }
            }
            .foregroundColor(.white)
                
            .navigationBarTitle(Text("Sent Memes"), displayMode: .inline)
            .navigationBarItems(
                leading: EditButton().foregroundColor(Color(#colorLiteral(red: 0.9607843137, green: 0.6941176471, blue: 0, alpha: 1))),
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

struct SentMemeCell: View {
    var memedImage: UIImage
    var topText: String
    var bottomText: String
    
    var body: some View {
        HStack {
            Image(uiImage: memedImage)
                .resizable()
                .frame(width: 50, height: 50)
                
            VStack(alignment: .leading) {
                Text(topText)
                Text(bottomText)
            }
            .lineLimit(1)
        }
            
    }
}
