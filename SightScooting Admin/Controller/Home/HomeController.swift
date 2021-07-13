//
//  HomeController.swift
//  SightScooting Admin
//
//  Created by Sarmad Ishfaq on 19/06/2021.
//

import UIKit

class HomeController: ParentController {

    //MARK:-UI-Elements
    lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.delegate = self
        tv.dataSource = self
        tv.separatorStyle = .none
        tv.register(HomeCell.self, forCellReuseIdentifier: cellId)
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    let noCityLabel = Label(text: "No City Found", textColor: .black, font: .setFont(fontName: .Poppins_SemiBold, fontSize: 25), alingment: .center)
    //MARK:-Properties
    let cellId = "cell"
    var city = [City]()
    //MARK:-ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Dashboard"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        addRightBarButton()
        getAllCities()
    }
    
    override func setupViews() {
        noCityLabel.alpha = 0
        view.addSubview(tableView)
        view.addSubview(noCityLabel)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            noCityLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noCityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    func addRightBarButton(){
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        navigationItem.rightBarButtonItem = rightButton
    }

    @objc func addButtonPressed(){
        let controller = AddRouteImageViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func getAllCities(){
        showLoadingView()
        ApiManager.shared.getAllCities { [weak self] city in
            self?.hideLoadingView()
            if let city = city {
                self?.city = city
                self?.tableView.reloadData()
            }
        }
    }
}
extension HomeController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return city.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? HomeCell {
            cell.cityImage.downloadImage(url: city[indexPath.row].cityImage)
            cell.cityName.text = city[indexPath.row].cityName
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.heightRatio
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = AddRouteController()
        controller.cityId = city[indexPath.row].id
        controller.routeArray = city[indexPath.row].routeObject
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
