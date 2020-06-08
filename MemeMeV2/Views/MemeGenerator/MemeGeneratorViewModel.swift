//
//  HomeViewModel.swift
//  MemeMeV1
//
//  Created by Renan Maganha on 14/05/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI

class MemeGeneratorViewModel: ObservableObject {
    //MARK: Image properties
    @Published var selectedImage = UIImage()
    @Published var webImage = ""
    
    //MARK: Top Text Properties
    @Published var topText                  = MemeGeneratorViewModel.defaultTopText
    @Published var topTextFontSize          = MemeGeneratorViewModel.defaultTextFontSize
    @Published var topTextPosition          = MemeGeneratorViewModel.defaultTextPosition
    @Published var topTextColor             = MemeGeneratorViewModel.defaultTextColor
    @Published var topTextStrokeColor       = MemeGeneratorViewModel.defaultTextStrokeColor
    
    //MARK: Bottom Text Properties
    @Published var bottomText               = MemeGeneratorViewModel.defaultBottomText
    @Published var bottomTextFontSize       = MemeGeneratorViewModel.defaultTextFontSize
    @Published var bottomTextPosition       = MemeGeneratorViewModel.defaultTextPosition
    @Published var bottomTextColor          = MemeGeneratorViewModel.defaultTextColor
    @Published var bottomTextStrokeColor    = MemeGeneratorViewModel.defaultTextStrokeColor
    
    //MARK: Default Text Properties
    static let defaultTopText = "TOP"
    static let defaultBottomText = "BOTTOM"
    static let defaultTextFontSize: CGFloat = 30
    static let defaultTextPosition: CGFloat = 0
    static let defaultTextColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static let defaultTextStrokeColor: UIColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    //MARK: Funcitions
    func restorePropertiesToDefaultValues() {
        selectedImage = UIImage()
        
        //MARK: Top Text Properties
        topText                  = MemeGeneratorViewModel.defaultTopText
        topTextFontSize          = MemeGeneratorViewModel.defaultTextFontSize
        topTextPosition          = MemeGeneratorViewModel.defaultTextPosition
        topTextColor             = MemeGeneratorViewModel.defaultTextColor
        topTextStrokeColor       = MemeGeneratorViewModel.defaultTextStrokeColor
        
        //MARK: Bottom Text Properties
        bottomText               = MemeGeneratorViewModel.defaultBottomText
        bottomTextFontSize       = MemeGeneratorViewModel.defaultTextFontSize
        bottomTextPosition       = MemeGeneratorViewModel.defaultTextPosition
        bottomTextColor          = MemeGeneratorViewModel.defaultTextColor
        bottomTextStrokeColor    = MemeGeneratorViewModel.defaultTextStrokeColor
    }
}

