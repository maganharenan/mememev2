//
//  ImageDetailView.swift
//  MemeMeV2
//
//  Created by Renan Maganha on 04/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI

struct ImageDetailView: View {
    @Binding var showControllers: Bool
    var image: UIImage
    
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.05882352941, green: 0.05882352941, blue: 0.05882352941, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .onAppear {
                    //Disables the tab bar when enters the memed image detail
                    self.showControllers = false
                }
                .onDisappear{
                    //Enables the tab bar when quits the memed image detail
                    self.showControllers = true
                }
        }
    }
}

struct ImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ImageDetailView(showControllers: .constant(false), image: #imageLiteral(resourceName: "1024x1024"))
    }
}
