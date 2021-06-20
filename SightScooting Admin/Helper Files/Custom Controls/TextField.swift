//
//  TextField.swift
//  GUM
//
//  Created by Malik Farhan Asim on 27/03/2021.
//

import UIKit

class TextField: UITextField {

    init(placeHolder: String, textColor: UIColor , font: UIFont) {
        super.init(frame: CGRect.zero)
        self.placeholder = placeHolder
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = textColor
        self.textAlignment = .natural
        self.font = UIFont(name: (font.fontName), size: CGFloat(Int(font.pointSize).autoSized))
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 39.autoSized, height: self.frame.height))
        self.leftView = padding
        self.leftViewMode = .always
        self.rightView = padding
        self.rightViewMode = .always
        self.tintColor = .black
        self.borderStyle = .none
        self.backgroundColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 0.48)
        self.layer.cornerRadius = 15.autoSized
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
