//
//  ImageWithBtn.swift
//  GUM
//
//  Created by Malik Farhan Asim on 11/04/2021.
//

import Foundation
import UIKit

class imageBtn : UIButton {
    init(image : String) {
        super.init(frame: CGRect.zero)
        setImage(UIImage(named: image), for: .normal)
        setImage(UIImage(named: image), for: .highlighted)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
