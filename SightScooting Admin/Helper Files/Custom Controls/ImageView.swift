//
//  ImageView.swift
//  GUM
//
//  Created by Malik Farhan Asim on 27/03/2021.
//

import UIKit

class ImageView: UIImageView {

    init(imageName: String) {
        super.init(frame: CGRect.zero)
        self.image = UIImage(named: imageName)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
