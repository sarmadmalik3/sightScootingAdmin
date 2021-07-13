//
//  Route.swift
//  SightScooting Admin
//
//  Created by Sarmad Ishfaq on 21/06/2021.
//

import Foundation
import UIKit

struct Route {
    var lat: String = ""
    var long: String = ""
    var locationImageUrl: String = ""
    var locationName: String = ""
    var locationDescription: String = ""
    var showMoreUrlString: String = ""
    var buyTicketUrlString: String = ""
}

struct City {
    var cityName : String = ""
    var cityImage: String = ""
    var id: String = ""
    var routeObject = [Route]()
}
