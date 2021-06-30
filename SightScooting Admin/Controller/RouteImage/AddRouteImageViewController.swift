//
//  AddRouteImageViewController.swift
//  SightScooting Admin
//
//  Created by Malik Farhan Asim on 30/06/2021.
//

import UIKit

class AddRouteImageViewController: UIViewController {
    
    let cityImage = ImageView(imageName: "city")
    let cityTf = TextField(placeHolder: "Enter City Name", textColor: .black, font: .setFont(fontName: .Poppins_Regular, fontSize: 13))
    let doneButton = Button(text: "Done", textColor: .white, font: .setFont(fontName: .Poppins_Regular, fontSize: 18), cornerRadious: 10, bgColor: #colorLiteral(red: 0.137254902, green: 0.3019607843, blue: 0.4196078431, alpha: 0.6925567209))
    lazy var addImageButton : UIButton = {
        let button = UIButton()
        button.setTitle("Select Image", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.137254902, green: 0.3019607843, blue: 0.4196078431, alpha: 0.6925567209)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(addImageButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpUI()
        doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
    }
    //MARK:-Helper Method
    func setUpUI(){
        view.addSubview(addImageButton)
        view.addSubview(cityImage)
        view.addSubview(cityTf)
        view.addSubview(doneButton)
        
        NSLayoutConstraint.activate([
            addImageButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.heightRatio),
            addImageButton.widthAnchor.constraint(equalToConstant: 130.widthRatio),
            addImageButton.heightAnchor.constraint(equalToConstant: 60.heightRatio),
            addImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            cityImage.topAnchor.constraint(equalTo: addImageButton.bottomAnchor, constant: 30.heightRatio),
            cityImage.widthAnchor.constraint(equalToConstant: 260.widthRatio),
            cityImage.heightAnchor.constraint(equalToConstant: 200.heightRatio),
            cityImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            cityTf.topAnchor.constraint(equalTo: cityImage.bottomAnchor, constant: 30.heightRatio),
            cityTf.widthAnchor.constraint(equalToConstant: 230.widthRatio),
            cityTf.heightAnchor.constraint(equalToConstant: 60.heightRatio),
            cityTf.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            
            doneButton.topAnchor.constraint(equalTo: cityTf.bottomAnchor, constant: 25.heightRatio),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100.widthRatio),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100.widthRatio),
            doneButton.heightAnchor.constraint(equalToConstant: 44.heightRatio),
 
        ])
      
    }
    @objc func addImageButtonPressed(){
        ImagePickerManager().pickImage(self) { [weak self] (image) in
            DispatchQueue.main.async { [weak self] in
                self?.cityImage.image = image
            }
        }
    }
    @objc func doneButtonPressed(){
        if cityTf.text == "" {
            showAlertWithoutCompletion("Please Enter the city name")
            return
        }
        addCityData()
        
    }

}
extension AddRouteImageViewController {
    
    
    func addCityData(){
        showLoadingView()
        ApiManager.shared.uploadMedia(image: cityImage.image!) { [weak self] imageUrl in
            
            ApiManager.shared.addCity(name: self?.cityTf.text ?? "", imageUrl: imageUrl!) { response, error in
                self?.hideLoadingView()
                if let response = response {
                    self?.showAlert(withTitle: "Alert", withMessage: response, completion: {
                        self?.navigationController?.popViewController(animated: true)
                    })
                }
            }
            
        }
    }
    
}

