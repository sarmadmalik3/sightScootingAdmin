//
//  Button.swift
//  GUM
//
//  Created by Malik Farhan Asim on 27/03/2021.
//

import UIKit

class Button: UIButton {
    
    var gradiantView = UIView()
    var cornerRadious : CGFloat = 0

    init(text: String, textColor: UIColor , font: UIFont , cornerRadious: Int , bgColor : UIColor) {
        super.init(frame: CGRect.zero)
        self.setTitle(text, for: .normal)
        self.setTitle(text, for: .highlighted)
        self.setTitleColor(textColor, for: .normal)
        self.setTitleColor(textColor, for: .highlighted)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = bgColor
        self.titleLabel?.font = UIFont(name: (font.fontName), size: CGFloat(Int(font.pointSize).heightRatio))
        self.layer.cornerRadius = cornerRadious.heightRatio
        self.cornerRadious = cornerRadious.heightRatio
//        initGradiant()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initGradiant(){
    

        gradiantView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)

//    gradiantView.backgroundColor = .white


    let layer0 = CAGradientLayer()

    layer0.colors = [

      UIColor(red: 0.962, green: 0.461, blue: 0.704, alpha: 1).cgColor,

      UIColor(red: 0.938, green: 0.301, blue: 0.609, alpha: 1).cgColor

    ]

    layer0.locations = [0, 1]

    layer0.startPoint = CGPoint(x: 0.25, y: 0.5)

    layer0.endPoint = CGPoint(x: 0.75, y: 0.5)

    layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: -0.97, b: 0, c: 0, d: -24.83, tx: 0.98, ty: 12.92))

    layer0.bounds = self.bounds.insetBy(dx: -0.5*self.bounds.size.width, dy: -0.5*self.bounds.size.height)

    layer0.position = self.center

    gradiantView.layer.addSublayer(layer0)


    gradiantView.layer.cornerRadius = cornerRadious


    self.addSubview(gradiantView)


    }

}
