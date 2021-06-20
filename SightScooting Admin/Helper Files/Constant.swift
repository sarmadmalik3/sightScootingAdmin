//
//  Constant.swift
//  Ma's Donuts
//
//  Created by Sarmad Malik on 06/05/2021.
//

import Foundation
import UIKit


struct appColors {
    
    static let primaryColor = #colorLiteral(red: 0.462745098, green: 0.1568627451, blue: 0.2745098039, alpha: 1)
    static let appBlue = #colorLiteral(red: 0.1450980392, green: 0.2431372549, blue: 0.4705882353, alpha: 1)
    static let navTitleColor = #colorLiteral(red: 0.0862745098, green: 0.0862745098, blue: 0.09803921569, alpha: 1)
    static let appGrayColor = #colorLiteral(red: 0.4274509804, green: 0.4274509804, blue: 0.4431372549, alpha: 1)
}

struct Constant {
    
    static let gooleApiKey = "AIzaSyD0GP_3Y3iV8wlhMbCGiqJjuK9i_-d7rig"
    
    public static func screenWidth()->CGFloat{
        var width: CGFloat = 0
        if let window = UIApplication.shared.keyWindow{
            width = window.frame.width
        }
        return width
    }
    public static func screenHeight()->CGFloat{
        var height: CGFloat = 0
        if let window = UIApplication.shared.keyWindow{
            height = window.frame.height
        }
        return height
    }
}
