//
//  AddRouteController.swift
//  SightScooting Admin
//
//  Created by Sarmad Ishfaq on 19/06/2021.
//

import UIKit
import GoogleMaps
import GooglePlaces

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
        tf.autocorrectionType = .no
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
    let showMoreFeild : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Url For show more"
        tf.rightViewMode = .always
        tf.leftViewMode = .always
        tf.tintColor = .black
        tf.autocorrectionType = .no
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
    let buyTicketFeild : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter Url for buy ticket"
        tf.rightViewMode = .always
        tf.leftViewMode = .always
        tf.tintColor = .black
        tf.autocorrectionType = .no
        tf.layer.cornerRadius = 10
        tf.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        tf.borderStyle = .none
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
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
    let doneButton : UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.titleLabel?.font = .setFont(fontName: .Poppins_SemiBold, fontSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Search Location"
        searchController.searchBar.searchBarStyle = .minimal
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.definesPresentationContext = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.searchTextField.isUserInteractionEnabled = true
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(textFieldTapped))
        searchController.searchBar.searchTextField.addGestureRecognizer(tapGuesture)
        return searchController
    }()
    
    //MARK:-Properties
    private var locationManager = CLLocationManager()
    private var marker = GMSMarker()
    var routeArray = [Route]()
    var cityId: String = ""
    var lat: String = ""
    var long: String = ""
    var isEditingMode: Bool = false
    
    //MARK:-ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Add Route"
        navigationItem.searchController = searchController
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        containerImage.layer.cornerRadius = 50
        bottomView.roundCorners([.topLeft , .topRight], radius: 10)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(taphandler))
        containerImage.isUserInteractionEnabled = true
        containerImage.addGestureRecognizer(tapGesture)
        
        addButton.addTarget(self, action: #selector(addButtonHandler), for: .touchUpInside)
        doneButton.addTarget(self, action: #selector(doneButtonHandler), for: .touchUpInside)
        animHide()
        getRouteFromCity()
    }
    
    override func setupViews() {
        view.addSubview(mapView)
        view.addSubview(doneButton)
        view.addSubview(blurView)
        blurView.addSubview(bottomView)
        bottomView.addSubview(addButton)
        bottomView.addSubview(nameField)
        bottomView.addSubview(showMoreFeild)
        bottomView.addSubview(buyTicketFeild)
        bottomView.addSubview(descrpitionTv)
        bottomView.addSubview(containerImage)
        containerImage.addSubview(placeImage)
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            doneButton.widthAnchor.constraint(equalToConstant: 150.widthRatio),
            doneButton.heightAnchor.constraint(equalToConstant: 50.heightRatio),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor , constant: -20.heightRatio),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 350.heightRatio),
            
            addButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor ,constant: -5.widthRatio),
            addButton.topAnchor.constraint(equalTo: bottomView.topAnchor ,constant: 5.heightRatio),
            
            nameField.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor ,constant: 15.widthRatio),
            nameField.topAnchor.constraint(equalTo: bottomView.topAnchor ,constant: 20.heightRatio),
            nameField.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor ,constant: -60.widthRatio),
            nameField.heightAnchor.constraint(equalToConstant: 50.heightRatio),
            
            showMoreFeild.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 10.heightRatio),
            showMoreFeild.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            showMoreFeild.heightAnchor.constraint(equalTo: nameField.heightAnchor),
            showMoreFeild.widthAnchor.constraint(equalToConstant: 162.widthRatio),
            
            buyTicketFeild.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 10.heightRatio),
            buyTicketFeild.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -15.widthRatio),
            buyTicketFeild.heightAnchor.constraint(equalTo: nameField.heightAnchor),
            buyTicketFeild.widthAnchor.constraint(equalToConstant: 162.widthRatio),
            
            
            
            descrpitionTv.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor ,constant: 15.widthRatio),
            descrpitionTv.topAnchor.constraint(equalTo: showMoreFeild.bottomAnchor ,constant: 10.heightRatio),
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
        
        if isValidationSucces() {
            showLoadingView()
            ApiManager.shared.uploadMedia(image: containerImage.image!) { [weak self] imageUrl in
                self?.hideLoadingView()
                let object = Route(lat: self!.lat, long: self!.long, locationImageUrl: imageUrl!, locationName: self!.nameField.text!, locationDescription: self!.descrpitionTv.text!,showMoreUrlString: self!.showMoreFeild.text! , buyTicketUrlString: self!.buyTicketFeild.text!)
                self?.routeArray.append(object)
                self?.animHide()
            }
        }
    }
    
    
    func isValidationSucces() -> Bool {
        if nameField.text == "" {
            showAlertWithoutCompletion("Enter Location Name")
            return false
        }
        if showMoreFeild.text == "" {
            showAlertWithoutCompletion("Enter Url for show more field")
            return false
        }
        if buyTicketFeild.text == "" {
            showAlertWithoutCompletion("Enter Url for buyTicket Feild")
            return false
        }
        if descrpitionTv.text == "" {
            showAlertWithoutCompletion("Enter Description about location")
            return false
        }
        if containerImage.image == UIImage() {
            showAlertWithoutCompletion("Select Location Image")
            return false
        }
        return true
    }
    
    @objc func doneButtonHandler(){
        mapView.clear()
        var bounds = GMSCoordinateBounds()
        for data in routeArray {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: Double(data.lat)!, longitude: Double(data.long)!)
            marker.userData = data
            marker.map = mapView
            bounds = bounds.includingCoordinate(marker.position)
        }
        
        let update = GMSCameraUpdate.fit(bounds, withPadding: 50)
        mapView.animate(with: update)
        let group = DispatchGroup()
        for routeObject in routeArray {
            group.enter()
            showLoadingView()
                ApiManager.shared.addRoutesInCity(cityId,routeObject) { response in
                    do { group.leave() }
                }
            }
        group.notify(queue: .main) { [weak self] in
            self?.hideLoadingView()
            self?.showAlert(withTitle: "Success", withMessage: "Routes has been added successfuly") {
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func getRouteFromCity(){
        showLoadingView()
        ApiManager.shared.getRoutesFromCity(cityId) {[weak self] routes in
            self?.hideLoadingView()
            if let route = routes {
                self?.routeArray = route
                if self?.routeArray.count ?? 0 > 0 {
                    self?.doneButton.isHidden = true
                    self?.isEditingMode = true
                }else{
                    self?.doneButton.isHidden = false
                    self?.isEditingMode = false
                }
                self?.showroutesOnMap()
            }
        }
    }
    
    func showroutesOnMap(){
        mapView.clear()
        var bounds = GMSCoordinateBounds()
        for data in routeArray {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: Double(data.lat)!, longitude: Double(data.long)!)
            marker.userData = data
            marker.map = mapView
            bounds = bounds.includingCoordinate(marker.position)
        }
        let update = GMSCameraUpdate.fit(bounds, withPadding: 50)
        mapView.animate(with: update)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(blurViewHandler))
        blurView.isUserInteractionEnabled = true
        blurView.addGestureRecognizer(tapGesture)
    }
    
    @objc func blurViewHandler(){
        if isEditingMode {
            animHide()
        }
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
        if !isEditingMode {
            plotMarker(AtCoordinate: coordinate, onMapView: mapView)
        }
       
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        if let data = marker.userData as? Route {
            animShow()
            showRouteData(data: data, userInteraction: false)
        }
        return true
    }
    
    //MARK:- Plot Marker Helper
    private func plotMarker(AtCoordinate coordinate : CLLocationCoordinate2D, onMapView vwMap : GMSMapView) {
        
        marker.position = coordinate
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
        buyTicketFeild.text = ""
        showMoreFeild.text = ""
        placeImage.image = UIImage(named: "image")
        containerImage.image = UIImage()
    }
    func showRouteData(data: Route , userInteraction: Bool){
        nameField.text = data.locationName
        showMoreFeild.text = data.showMoreUrlString
        buyTicketFeild.text = data.buyTicketUrlString
        descrpitionTv.text = data.locationDescription
        placeImage.image = UIImage()
        nameField.isUserInteractionEnabled = userInteraction
        descrpitionTv.isUserInteractionEnabled = userInteraction
        containerImage.isUserInteractionEnabled = userInteraction
        addButton.isHidden = !userInteraction
        if data.locationImageUrl != "" {
            containerImage.downloadImage(url: data.locationImageUrl)
        }
    }
}

extension AddRouteController : GMSAutocompleteViewControllerDelegate{
    
    @objc func textFieldTapped(){
        let acController = GMSAutocompleteViewController()
        acController.delegate = self
        navigationController?.pushViewController(acController, animated: true)
    }
    
    // Handle the user's selection.
     func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        searchController.searchBar.searchTextField.text = place.formattedAddress ?? ""
        mapView.camera = GMSCameraPosition(target: place.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
        navigationController?.popViewController(animated: true)
     }

     func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
       // TODO: handle the error.
       print("Error: \(error)")
        navigationController?.popViewController(animated: true)
     }

     // User cancelled the operation.
     func wasCancelled(_ viewController: GMSAutocompleteViewController) {
       print("Autocomplete was cancelled.")
        navigationController?.popViewController(animated: true)
     }
}
