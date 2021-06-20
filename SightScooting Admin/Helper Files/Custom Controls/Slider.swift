//
//  Slider.swift
//  Ma Donuts
//
//  Created by Sarmad Malik on 02/06/2021.
//

import Foundation
import UIKit

class CustomSlide: UISlider {

     @IBInspectable var trackHeight: CGFloat = 5
//
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let point = CGPoint(x: bounds.minX, y: bounds.midY)
        return CGRect(origin: point, size: CGSize(width: bounds.width, height: 15))
    }

}
