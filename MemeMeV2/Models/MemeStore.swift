//
//  MemeStore.swift
//  MemeMeV2
//
//  Created by Renan Maganha on 06/06/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI
import Combine

class MemeStore: ObservableObject {
    @Published var memes: [Meme] = memesList
}
