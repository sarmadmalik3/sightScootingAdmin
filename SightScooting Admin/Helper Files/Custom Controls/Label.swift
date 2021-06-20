//
//  Label.swift
//  GUM
//
//  Created by Malik Farhan Asim on 27/03/2021.
//

import UIKit

class Label: UILabel {

    init(text: String, textColor: UIColor , font: UIFont , alingment: NSTextAlignment) {
        super.init(frame: CGRect.zero)
        self.text = text
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = textColor
        self.textAlignment = alingment
        self.numberOfLines = 0
        self.font = UIFont(name: (font.fontName), size: CGFloat(Int(font.pointSize).heightRatio))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
