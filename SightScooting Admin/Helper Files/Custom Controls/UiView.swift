//
//  UiView.swift
//  GUM
//
//  Created by Malik Farhan Asim on 16/04/2021.
//

import Foundation
import UIKit


class View : UIView {
    init(bgcolor : UIColor){
        super.init(frame: CGRect.zero)
        self.backgroundColor = bgcolor
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
