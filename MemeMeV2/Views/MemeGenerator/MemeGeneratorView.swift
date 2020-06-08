//
//  ContentView.swift
//  MemeMeV1
//
//  Created by Renan Maganha on 14/05/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import SwiftUI
import Combine
import SDWebImageSwiftUI

struct MemeGeneratorView: View {
    //MARK: Properties
    @ObservedObject var homeVM = MemeGeneratorViewModel()
    @State private var rect: CGRect = .zero
    @State var keyboardHeight: CGFloat = 0
    @State var showControlBars = true
    
    //Sheet triggers
    @State var pickAnImageFromCamera = false
    @State var pickAnImageFromAlbum = false
    @State var shareMemedImage = false
    @State var showWebImageSelector = false
    
    //Pop-Up triggers
    @State var showTextFieldProperties = false
    @State var showTextFieldPosition = false
    @State var showTextFieldColorPicker = false
    
    @State var memedImage: UIImage? = nil
    @Binding var showMemeGenerator: Bool
    
    //MARK: Functions
    func generateMeme() {
        //Hides the controllers to render the view
        self.showControlBars = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            //Renders the view
            self.memedImage = UIApplication.shared.windows[0].rootViewController?.view!.setImage(rect: self.rect)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                //Shows the controllers again and trigger the activity view
                self.showControlBars = true
                self.shareMemedImage.toggle()
            }
        }
    }
    
    func closeAllPopUps() {
        showTextFieldProperties = false
        showTextFieldPosition = false
        showTextFieldColorPicker = false
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Color(#colorLiteral(red: 0.05950586929, green: 0.05950586929, blue: 0.05950586929, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            //MARK: Image
            ZStack {
                WebImage(url: URL(string: homeVM.webImage))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Image(uiImage: homeVM.selectedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                //MARK: TextFields
                VStack {
                    TextFieldItem(text: $homeVM.topText, strokeColor: $homeVM.topTextStrokeColor, fontSize: $homeVM.topTextFontSize, textColor: $homeVM.topTextColor)
                        .offset(y: homeVM.topTextPosition)
                    Spacer()
                    TextFieldItem(text: $homeVM.bottomText, strokeColor: $homeVM.bottomTextStrokeColor, fontSize: $homeVM.bottomTextFontSize, textColor: $homeVM.bottomTextColor)
                        .offset(y: homeVM.bottomTextPosition)
                        .padding(.bottom, keyboardHeight)
                        .onReceive(Publishers.keyboardHeight) { self.keyboardHeight = $0 }
                }
                .padding(.vertical, 50)
            }
            .background(RectSettings(rect: $rect))
            
            if showControlBars {
                VStack {
                    
                    //MARK: ToolBar
                    HStack(spacing: 60) {
                        Spacer()
                        
                        //Shares memed image
                        Button(action: {
                            if self.homeVM.webImage != "" || self.homeVM.selectedImage != UIImage() {
                                self.closeAllPopUps()
                                self.generateMeme()
                            }
                        }, label: {
                            Image(systemName: "square.and.arrow.up")
                                .modifier(ButtonsLabel())
                        })
                        .sheet(isPresented: self.$shareMemedImage) {
                            ActivityView(topText: self.homeVM.topText, bottomText: self.homeVM.bottomText, originalImage: self.homeVM.selectedImage, memedImage: self.memedImage!, activityItems: [self.memedImage!])
                        }
                        
                        //Shows a pop-up that allows user to edit color settings
                        Button(action: {
                            self.showTextFieldProperties = false
                            self.showTextFieldPosition = false
                            self.showTextFieldColorPicker.toggle()
                        }, label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(Color.red)
                                    .frame(height: 15)
                                
                                Circle()
                                    .foregroundColor(Color.green)
                                    .blendMode(.screen)
                                    .frame(height: 15)
                                    .offset(x: 10)
                                Circle()
                                    .foregroundColor(Color.blue)
                                    .blendMode(.screen)
                                    .frame(height: 15)
                                    .offset(x: 5, y: -5)
                            }
                            .frame(width: 15)
                            .offset(y: 3)
                            .background(Color.clear)
                            .contentShape(Rectangle())
                            .frame(width: 30, height: 30)
                        })
                        
                        //Shows an pop-up that allows the user to change textfields properties
                        Button(action: {
                            self.showTextFieldColorPicker = false
                            self.showTextFieldPosition = false
                            self.showTextFieldProperties.toggle()
                        }, label: {
                            Image(systemName: "textformat.size")
                                .modifier(ButtonsLabel())
                        })
                        
                        //Shows an pop-up that allows user to change the position of textfields
                        Button(action: {
                            self.showTextFieldColorPicker = false
                            self.showTextFieldProperties = false
                            self.showTextFieldPosition.toggle()
                        }, label: {
                            Image(systemName: "perspective")
                                .modifier(ButtonsLabel())
                        })
                        
                        Spacer()
                        
                    }
                    .frame(height: 50)
                    .background(BackgroundBarStyle(fx: UIBlurEffect(style: .dark)).edgesIgnoringSafeArea(.top))
                    .edgesIgnoringSafeArea(.horizontal)
                    .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    
                    Spacer()
                    
                    //MARK: TabBar
                    HStack(spacing: 60) {
                        
                        Spacer()
                        
                        //Pick an image from camera
                        Button(action: {
                            self.closeAllPopUps()
                            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                                self.pickAnImageFromCamera.toggle()
                            }
                        }, label: {
                            Image(systemName:"camera")
                                .modifier(ButtonsLabel())
                        })
                            .sheet(isPresented: self.$pickAnImageFromCamera) {
                                ImagePickerView(sourceType: .constant("camera"), isPresented: self.$pickAnImageFromAlbum, selectedImage: self.$homeVM.selectedImage, webImage: self.$homeVM.webImage)
                        }
                        
                        //Pick an image from album
                        Button(action: {
                            self.closeAllPopUps()
                            self.pickAnImageFromAlbum.toggle()
                        }, label: {
                            Image(systemName:"photo")
                                .modifier(ButtonsLabel())
                        })
                            .sheet(isPresented: self.$pickAnImageFromAlbum) {
                                ImagePickerView(sourceType: .constant("photoLibrary"), isPresented: self.$pickAnImageFromAlbum, selectedImage: self.$homeVM.selectedImage, webImage: self.$homeVM.webImage)
                        }
                        
                        //Pick an image from web url
                        Button(action: {
                            self.closeAllPopUps()
                            self.showWebImageSelector.toggle()
                        }, label: {
                            Image(systemName: "magnifyingglass")
                                .modifier(ButtonsLabel())
                        })
                        
                        //Clears everything
                        Button(action: {
                            self.closeAllPopUps()
                            self.homeVM.restorePropertiesToDefaultValues()
                            self.showMemeGenerator.toggle()
                        }, label: {
                            Image(systemName: "xmark")
                                .modifier(ButtonsLabel())
                        })
                        
                        Spacer()
                    }
                    .frame(height: 50)
                    .background(BackgroundBarStyle(fx: UIBlurEffect(style: .dark)).edgesIgnoringSafeArea(.bottom))
                    .edgesIgnoringSafeArea(.horizontal)
                    .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                }
            }
            
            if showWebImageSelector {
                WebImageSelectorView(webImage: $homeVM.webImage, showWebImageSelector: $showWebImageSelector, deviceImage: $homeVM.selectedImage)
            }
            
            //MARK: Pop-ups
            VStack {
                
                if showTextFieldProperties {
                    TextFieldPropertiesItem(positionX: .constant(45), topTextFontSize: $homeVM.topTextFontSize, bottomTextFontSize: $homeVM.bottomTextFontSize)
                        .offset(y: 25)
                }
                
                if showTextFieldPosition {
                    TextFieldPositionItem(positionX: .constant(135), topTextPosition: $homeVM.topTextPosition, bottomTextPosition: $homeVM.bottomTextPosition)
                        .offset(y: 25)
                }
                
                if showTextFieldColorPicker {
                    TextFieldColorPickerItem(positionX: .constant(-39), topStrokeColor: $homeVM.topTextStrokeColor, topTextColor: $homeVM.topTextColor, bottomStrokeColor: $homeVM.bottomTextStrokeColor, bottomTextColor: $homeVM.bottomTextColor)
                    .offset(y: 50)
                }
                
                Spacer()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MemeGeneratorView(showMemeGenerator: .constant(true))
    }
}

//MARK: TextFieldStyle
struct TextFieldItem: View {
    @Binding var text: String
    @Binding var strokeColor: UIColor
    @Binding var fontSize: CGFloat
    @Binding var textColor: UIColor
    
    var body: some View {
        ZStack {
            //Stroke
            Text(text)
                .offset(x: -2, y: 2)
            Text(text)
                .offset(x: 2, y: 2)
            Text(text)
                .offset(x: -2, y: -2)
            Text(text)
                .offset(x: 2, y: -2)
            
            //Text
            TextField("", text: $text)
                .font(.custom("HelveticaNeue-CondensedBlack", size: fontSize))
                .autocapitalization(.allCharacters)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(textColor))
                .onTapGesture {
                    //Erase the text if their value is equal to default value
                    if self.text == "TOP" || self.text == "BOTTOM" {
                        self.text = ""
                    }
            }
        }
        .font(.custom("HelveticaNeue-CondensedBlack", size: fontSize))
        .foregroundColor(Color(strokeColor))
    }
}

//MARK: Return a clear rectangle to render the view
struct RectSettings: View {
    @Binding var rect: CGRect
    
    var body: some View {
        GeometryReader { geometry in
            self.setView(proxy: geometry)
        }
    }
    
    func setView(proxy: GeometryProxy) -> some View{
        DispatchQueue.main.async {
            self.rect = proxy.frame(in: .global)
        }
        return Rectangle().fill(Color.clear)
    }
}
