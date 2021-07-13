//
//  ApiManager.swift
//  AdminPanelDelicioiusFood
//
//  Created by Malik Farhan Asim on 07/06/2021.
//

import Foundation
//import Firebase
import FirebaseStorage
import Firebase
import UIKit

class ApiManager {
    
    var ref: DatabaseReference!
    
    init() {
        ref = Database.database().reference()
    }
    static let shared = ApiManager()
    
    func addCity(name: String , imageUrl : String , completion : @escaping (_ message: String? , _ error: String?) -> () ){
        
        ref.child("City").childByAutoId().setValue(["name" : name ,"imageUrl" : imageUrl ]) { (error, snapshot) in
            if let err = error {
                print(err.localizedDescription)
                completion(nil , err.localizedDescription)
            }else{
                completion("Data saved succesfully" , nil)
            }
        }
    }
    
    
        func uploadMedia(image : UIImage ,completion: @escaping (_ url: String?) -> Void) {
            let storageRef = Storage.storage().reference().child("City").child("\(String.random()).png")
           if let uploadData = image.jpegData(compressionQuality: 0.5) {
               storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                   if error != nil {
                       print("error")
                       completion(nil)
                   } else {
    
                       storageRef.downloadURL(completion: { (url, error) in
    
                        print(url?.absoluteString ?? "")
                           completion(url?.absoluteString)
                       })
                   }
               }
           }
       }
    
    func getAllCities(completion: @escaping(_ city: [City]?) -> Void){
        ref.child("City").observe(.value) { snapShot in
            
            var cityModel = [City]()
            
            for child in snapShot.children {
                
                let snap = child as! DataSnapshot
                
                if let value = snap.value as? [String : Any] {
                    let name = value["name"] as! String
                    let image = value["imageUrl"] as! String
                    
                    let object = City(cityName: name, cityImage: image, id: snap.key)
                    cityModel.append(object)
                }
                
                
            }
            completion(cityModel)
        }
    }
    
    func getRoutesFromCity(_ cityId: String ,completion: @escaping(_ route: [Route]?) -> ()){
        
        var routeArray = [Route]()
        var routeObject = Route()
        ref.child("City").child(cityId).child("routes").observeSingleEvent(of: .value) { snapShot in
            for child in snapShot.children {
                
                let snap = child as! DataSnapshot
                
                if let value = snap.value as? [String: Any]{
                    
                    if let lat = value["lat"] as? String {
                        routeObject.lat = lat
                    }
                    if let long = value["lng"] as? String {
                        routeObject.long = long
                    }
                    if let locationDesc = value["locationDescription"] as? String {
                        routeObject.locationDescription = locationDesc
                    }
                    if let locationName = value["locationName"] as? String {
                        routeObject.locationName = locationName
                    }
                    if let showMore = value["showMoreUrlString"] as? String {
                        routeObject.showMoreUrlString = showMore
                    }
                    
                    if let buyTicket = value["buyTicketUrlString"] as? String {
                        routeObject.buyTicketUrlString = buyTicket
                    }
                    
                    if let imageUrl = value["imageUrl"] as? String {
                        routeObject.locationImageUrl = imageUrl
                    }
                    
                    routeArray.append(routeObject)
                }
            }
            
            completion(routeArray)
        }
    }
    
    func addRoutesInCity(_ cityId: String, _ routeObject: Route, completion:@escaping(_ sucess:String)->()){
        
        ref.child("City").child(cityId).child("routes").childByAutoId().setValue(
            [
                "lat" : routeObject.lat,
                "lng": routeObject.long,
                "locationName": routeObject.locationName,
                "locationDescription": routeObject.locationDescription,
                "showMoreUrlString": routeObject.showMoreUrlString,
                "buyTicketUrlString": routeObject.buyTicketUrlString,
                "imageUrl": routeObject.locationImageUrl
            ]) { error, response in
            
            if error == nil {
                completion("")
            }
            
        }
    }
}
