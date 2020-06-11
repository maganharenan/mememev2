//
//  Extensions.swift
//  MemeMeV2
//
//  Created by Renan Maganha on 26/05/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI
import Combine

//MARK: Keyboard notifications
extension Publishers {

    static var keyboardHeight: AnyPublisher<CGFloat, Never> {

        let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
            .map { $0.keyboardHeight }
        
        let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        

        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}

//MARK: Renders the screen
extension UIView {
    func setImage(rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: rect)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}

//MARK: Grid Catalog Style
extension GridStructure {
    func getCurrentIndex(row: Int, col: Int) -> Int {
        let currentIndex = (row * defineColumnsNumber()) + col
        
        return currentIndex
    }
    
    //Defines the number of rows of the Grid
    func defineRowsNumber(items: Int, columns: Int) -> Int {
        var numberOfRows = 0
        let division = items % columns
        
        if division != 0 {
            numberOfRows = items / columns + 1
        } else {
            numberOfRows = items / columns
        }
        
        return numberOfRows
    }
    
    //Defines the number of columns of the Grid
    func defineColumnsNumber() -> Int {
        var columns = 0
        
        if orientationInfo.orientation == .landscape {
            columns = 5
        } else {
            columns = 3
        }
        
        return columns
    }
    
    //Defines the size of the thumbnail of the Grid
    func defineThumbnailSize() -> CGFloat {
        let spacing: CGFloat = 12
        let timesSpacing: CGFloat = CGFloat(defineColumnsNumber() + 1)
        let screenSize = UIScreen.main.bounds.width
        
        let thumbnailSize = (screenSize - timesSpacing * spacing) / CGFloat(defineColumnsNumber())

        return thumbnailSize
    }
}

//MARK: List and Navigation Bar style
extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        //Navigation Bar Appearance
        let customNavBar = UINavigationBarAppearance()
        customNavBar.configureWithTransparentBackground()
        customNavBar.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.07058823529, blue: 0.07843137255, alpha: 1)
        customNavBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        customNavBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = customNavBar
        UINavigationBar.appearance().compactAppearance = customNavBar
        UINavigationBar.appearance().scrollEdgeAppearance = customNavBar
        UINavigationBar.appearance().tintColor = .white
        
        //List Appearance
        UITableView.appearance().backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        UITableViewCell.appearance().backgroundColor = #colorLiteral(red: 0.1098039216, green: 0.1098039216, blue: 0.1176470588, alpha: 1)
    }
}

//MARK: Meme Generator Width
extension HomeView {
    func getWidth(orientation: OrientationInfo) -> CGFloat {
        let screenSize = UIScreen.main.bounds
        var width: CGFloat = 0
        
        if screenSize.height < screenSize.width {
            if orientation.orientation == .landscape {
                width = screenSize.width
            } else {
                width = screenSize.height
            }
        } else {
            if orientation.orientation == .portrait {
                width = screenSize.width
            } else {
                width = screenSize.height
            }
        }
        
        return width
    }
}
