//
//  HomeCell.swift
//  SightScooting Admin
//
//  Created by Sarmad Ishfaq on 19/06/2021.
//

import UIKit

class HomeCell: UITableViewCell {

    //MARK:-UI-Elements
    let cityImage = ImageView(imageName: "city")
    let cityName = Label(text: "CityName", textColor: .black, font: .setFont(fontName: .Poppins_SemiBold, fontSize: 20), alingment: .natural)

    //MARK:-Cell Method
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        cityImage.layer.cornerRadius = 15.autoSized
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:-Constraints
    func setupViews(){
        addSubview(cityImage)
        addSubview(cityName)
        NSLayoutConstraint.activate([
        
            cityImage.leadingAnchor.constraint(equalTo: leadingAnchor , constant: 25.widthRatio),
            cityImage.trailingAnchor.constraint(equalTo: trailingAnchor , constant: -25.widthRatio),
            cityImage.topAnchor.constraint(equalTo: topAnchor , constant: 10.heightRatio),
            cityImage.bottomAnchor.constraint(equalTo: bottomAnchor , constant: -10.heightRatio),
        
            cityName.leadingAnchor.constraint(equalTo: cityImage.leadingAnchor, constant: 15.widthRatio),
            cityName.topAnchor.constraint(equalTo: cityImage.topAnchor, constant: 10.heightRatio),
            
        ])
    }
}
