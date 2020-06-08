//
//  Meme.swift
//  MemeMeV2
//
//  Created by Renan Maganha on 14/05/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI

var memesList: [Meme] = []

struct Meme: Hashable {
    var topText: String
    var bottomText: String
    var originalImage: UIImage
    var memedImage: UIImage
}

