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
 
}
