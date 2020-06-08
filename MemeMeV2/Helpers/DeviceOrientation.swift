//
//  DeviceOrientation.swift
//  MemeMeV2
//
//  Created by Renan Maganha on 31/05/20.
//  Copyright © 2020 Renan Maganha. All rights reserved.
//

import UIKit

final class OrientationInfo: ObservableObject {
    enum Orientation {
        case portrait
        case landscape
    }
      
    @Published var orientation: Orientation
      
    private var _observer: NSObjectProtocol?
      
    init() {
       
        if UIDevice.current.orientation.isLandscape {
            self.orientation = .landscape
        }
        else {
            self.orientation = .portrait
        }
          
        _observer = NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: nil) { [unowned self] note in
            guard let device = note.object as? UIDevice else {
                return
            }
            if device.orientation.isPortrait {
                self.orientation = .portrait
            }
            else if device.orientation.isLandscape {
                self.orientation = .landscape
            }
        }
    }
      
    deinit {
        if let observer = _observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
}
