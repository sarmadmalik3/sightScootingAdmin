//
//  AddRouteController.swift
//  SightScooting Admin
//
//  Created by Sarmad Ishfaq on 19/06/2021.
//

import UIKit
import GoogleMaps

class AddRouteController: ParentController {

    //MARK:-UI-Elements
    lazy var mapView : GMSMapView = {
        let view = GMSMapView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let bottomView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let addButton : UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.titleLabel?.font = .setFont(fontName: .Poppins_Medium, fontSize: 12)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let nameField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Place Name"
        tf.rightViewMode = .always
        tf.leftViewMode = .always
        tf.tintColor = .black
        tf.layer.cornerRadius = 10
        tf.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        tf.borderStyle = .none
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        tf.leftView = leftView
        tf.rightView = rightView
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    let descrpitionTv : UITextView = {
        let tv = UITextView()
        tv.layer.cornerRadius = 10
        tv.tintColor = .black
        tv.font = .setFont(fontName: .Poppins_Medium, fontSize: 14)
        tv.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    let placeImage : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "image")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let containerImage : UIImageView = {
        let image = UIImageView()
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.borderWidth = 1
        image.backgroundColor = .clear
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    let blurView : UIView = {
        let view = UIView()
        view.alpha = 0
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK:-Properties
    private var locationManager = CLLocationManager()
    var routeArray = [Route]()
    var lat: String = ""
    var long: String = ""
    
    //MARK:-ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Add Route"
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        containerImage.layer.cornerRadius = 50
        bottomView.roundCorners([.topLeft , .topRight], radius: 10)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(taphandler))
        containerImage.isUserInteractionEnabled = true
        containerImage.addGestureRecognizer(tapGesture)
        addButton.addTarget(self, action: #selector(addButtonHandler), for: .touchUpInside)
        animHide()
    }
    
    override func setupViews() {
        view.addSubview(mapView)
        view.addSubview(blurView)
        blurView.addSubview(bottomView)
        bottomView.addSubview(addButton)
        bottomView.addSubview(nameField)
        bottomView.addSubview(descrpitionTv)
        bottomView.addSubview(containerImage)
        containerImage.addSubview(placeImage)
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 300.heightRatio),
            
            addButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor ,constant: -5.widthRatio),
            addButton.topAnchor.constraint(equalTo: bottomView.topAnchor ,constant: 5.heightRatio),
            
            nameField.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor ,constant: 15.widthRatio),
            nameField.topAnchor.constraint(equalTo: bottomView.topAnchor ,constant: 20.heightRatio),
            nameField.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor ,constant: -60.widthRatio),
            nameField.heightAnchor.constraint(equalToConstant: 50.heightRatio),
            
            descrpitionTv.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor ,constant: 15.widthRatio),
            descrpitionTv.topAnchor.constraint(equalTo: nameField.bottomAnchor ,constant: 20.heightRatio),
            descrpitionTv.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor ,constant: -120.widthRatio),
            descrpitionTv.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor ,constant: -20.heightRatio),
            
            containerImage.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor ,constant: -10.widthRatio),
            containerImage.centerYAnchor.constraint(equalTo: descrpitionTv.centerYAnchor),
            containerImage.widthAnchor.constraint(equalToConstant: 100),
            containerImage.heightAnchor.constraint(equalToConstant: 100),
            
            placeImage.centerYAnchor.constraint(equalTo: containerImage.centerYAnchor),
            placeImage.centerXAnchor.constraint(equalTo: containerImage.centerXAnchor),
            placeImage.widthAnchor.constraint(equalToConstant: 30),
            placeImage.heightAnchor.constraint(equalToConstant: 30),
            
        ])
    }
    
    @objc func taphandler(){
        ImagePickerManager().pickImage(self) { [weak self] (image) in
            DispatchQueue.main.async { [weak self] in
                self?.placeImage.image = UIImage()
                self?.containerImage.image = image
            }
        }
    }
    @objc func addButtonHandler(){
        animHide()
    }

}
extension AddRouteController : CLLocationManagerDelegate , GMSMapViewDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }else{
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        locationManager.stopUpdatingLocation()
    }
    
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        plotMarker(AtCoordinate: coordinate, onMapView: mapView)
    }
    
    //MARK:- Plot Marker Helper
    private func plotMarker(AtCoordinate coordinate : CLLocationCoordinate2D, onMapView vwMap : GMSMapView) {
        let marker = GMSMarker(position: coordinate)
        marker.map = vwMap
        lat = String(coordinate.latitude)
        long = String(coordinate.longitude)
        animShow()
    }
    func animShow(){
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveEaseIn],
                       animations: { [weak self] in
                        self?.blurView.alpha = 1
                        self?.bottomView.transform = .identity
                        self?.bottomView.layoutIfNeeded()
                        self?.bottomView.alpha = 1
        }, completion: nil)
        clearBottomView()
    }
    func animHide(){
        UIView.animate(withDuration: 0.4, delay: 0, options: [.curveLinear],
                       animations: { [weak self] in
                        self?.blurView.alpha = 0
                        self?.bottomView.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.minY + 300)
                        self?.bottomView.layoutIfNeeded()
                        self?.bottomView.alpha = 0
        },  completion: {(_ completed: Bool) -> Void in
            })
    }
    func clearBottomView(){
        descrpitionTv.text = ""
        nameField.text = ""
        placeImage.image = UIImage(named: "image")
        containerImage.image = UIImage()
    }
}

