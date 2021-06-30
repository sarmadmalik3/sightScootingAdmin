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
    
//    func getRestaurantData(completion : @escaping(_ model : [RestaurantModel]?) -> Void){
//        ref.child("Restaurant").observe(.value) { (snapshot) in
//
//            var restaurantObject = [RestaurantModel]()
//
//            for child in snapshot.children {
//
//                let snap = child as! DataSnapshot
//                if let value = snap.value as? [String : Any] {
//                    let name = value["name"] as! String
//                    let image = value["imageUrl"] as! String
//                    let deliveryTime = value["deliveryTime"] as! String
//                    let deliveryCharges = value["deliveryCharges"] as! String
//
//                    let object = RestaurantModel(name: name, deliveryTime: deliveryTime,deliveryCharges: deliveryCharges ,imageurl: image, key: snap.key , isHomeService: false)
//                    restaurantObject.append(object)
//                 }
//            }
//            completion(restaurantObject)
//        }
//    }
//    func addHomeService(name: String , deliveryTime: String , imageUrl : String ,deliveryCharges: String, completion : @escaping (_ message: String? , _ error: String?) -> () ){
//
//        ref.child("HomeService").childByAutoId().setValue(["name" : name , "deliveryTime" : deliveryTime , "imageUrl" : imageUrl, "deliveryCharges" : deliveryCharges ]) { (error, snapshot) in
//            if let err = error {
//                print(err.localizedDescription)
//                completion(nil , err.localizedDescription)
//            }else{
//                completion("Data saved succesfully" , nil)
//            }
//        }
//    }
//
//    func getHomeData(completion : @escaping(_ model : [RestaurantModel]?) -> Void){
//        ref.child("HomeService").observe(.value) { (snapshot) in
//
//
//            var restaurantObject = [RestaurantModel]()
//
//            for child in snapshot.children {
//
//                let snap = child as! DataSnapshot
//                if let value = snap.value as? [String : Any] {
//                    let name = value["name"] as! String
//                    let image = value["imageUrl"] as! String
//                    let deliveryTime = value["deliveryTime"] as! String
//                    let deliveryCharges = value["deliveryCharges"] as! String
//
//                    let object = RestaurantModel(name: name, deliveryTime: deliveryTime,deliveryCharges: deliveryCharges ,imageurl: image , key: snap.key, isHomeService: true)
//                    restaurantObject.append(object)
//                 }
//            }
//            completion(restaurantObject)
//        }
//    }
//
//    func uploadMedia( serviceType : service  ,image : UIImage ,completion: @escaping (_ url: String?) -> Void) {
//
//        let storageRef = Storage.storage().reference().child(serviceType.rawValue).child("\(String.random()).png")
//       if let uploadData = image.jpegData(compressionQuality: 0.5) {
//           storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
//               if error != nil {
//                   print("error")
//                   completion(nil)
//               } else {
//
//                   storageRef.downloadURL(completion: { (url, error) in
//
//                    print(url?.absoluteString ?? "")
//                       completion(url?.absoluteString)
//                   })
//               }
//           }
//       }
//   }
//    func addCatagory(restaurantType : Restaturant, key : String ,name : String , imageUrl : String , completion  : @escaping (_ message : String? , _ error : String?) -> ()){
//        ref.child(restaurantType.rawValue).child(key).child("Category").childByAutoId().setValue(["name" : name , "imageUrl" : imageUrl])
//            { (error , snapshot) in
//            if let err = error
//            {
//                print(err.localizedDescription)
//                completion(nil , err.localizedDescription)
//            }
//            else
//            {
//                completion("Data save Successfully" , nil)
//            }
//
//        }
//
//    }
//
//    func getCategories(restaurantType : Restaturant, key: String , completion : @escaping (_ category: [CateogryModel]?) -> Void){
//        ref.child(restaurantType.rawValue).child(key).child("Category").observe(.value) { (snapshot) in
//
//            var catObject = [CateogryModel]()
//
//            for child in snapshot.children {
//
//                let snap = child as! DataSnapshot
//                if let value = snap.value as? [String : Any] {
//                    let name = value["name"] as! String
//                    let image = value["imageUrl"] as! String
//
//                    let object = CateogryModel(name: name, imageUrl: image, key: snap.key)
//                    catObject.append(object)
//                 }
//            }
//            completion(catObject)
//        }
//    }
//
//    func addItem(restaurantType : Restaturant, key : String ,categoryKey: String ,name : String , price : String, imageUrl : String ,itemDesc : String ,completion  : @escaping (_ message : String? , _ error : String?) -> ()){
//        ref.child(restaurantType.rawValue).child(key).child("Category").child(categoryKey).child("Item").childByAutoId().setValue(["name" : name , "price" : price, "imageUrl" : imageUrl , "description" : itemDesc])
//            { (error , snapshot) in
//            if let err = error
//            {
//                print(err.localizedDescription)
//                completion(nil , err.localizedDescription)
//            }
//            else
//            {
//                completion("Data save Successfully" , nil)
//            }
//
//        }
//
//    }
//    func getItem(restaurantType : Restaturant, key: String , categoryKey: String , completion : @escaping (_ category: [ItemModel]?) -> Void){
//        ref.child(restaurantType.rawValue).child(key).child("Category").child(categoryKey).child("Item").observe(.value) { (snapshot) in
//
//            var itemObject = [ItemModel]()
//
//            for child in snapshot.children {
//
//                let snap = child as! DataSnapshot
//                var name = ""
//                var price = ""
//                var image = ""
//                var addOnTitle = ""
//
//
//                if let value = snap.value as? [String : Any] {
//                    if let nameString = value["name"] as? String {
//                        name = nameString
//                    }
//                    if  let priceString = value["price"] as? String {
//                        price = priceString
//                    }
//                    if let imageString = value["imageUrl"] as? String {
//                        image = imageString
//                    }
//
//                    if let addOnTitleString = value["addOnTitle"] as? String {
//                        addOnTitle = addOnTitleString
//                    }
//
//                    let object = ItemModel(name: name, price: price , imageUrl: image, key: snap.key, addOnTitle: addOnTitle)
//                    itemObject.append(object)
//                 }
//            }
//            completion(itemObject)
//        }
//    }
//
//    func addAddOns(restaurantType : Restaturant, restaurantKey : String ,itemKey: String ,name : String , price : String, completion  : @escaping (_ message : String? , _ error : String?) -> ()){
//        ref.child(restaurantType.rawValue).child(restaurantKey).child("Item").child(itemKey).child("AddOns").childByAutoId().setValue(["name" : name , "price" : price])
//            { (error , snapshot) in
//            if let err = error
//            {
//                print(err.localizedDescription)
//                completion(nil , err.localizedDescription)
//            }
//            else
//            {
//                completion("Data save Successfully" , nil)
//            }
//        }
//    }
//    func addAddOnsTitle(restaurantType : Restaturant, restaurantKey : String ,itemKey: String , addOnTitle : String , completion  : @escaping (_ message : String? , _ error : String?) -> ()){
//        ref.child(restaurantType.rawValue).child(restaurantKey).child("Item").child(itemKey).updateChildValues(["addOnTitle" : addOnTitle])
//            { (error , snapshot) in
//            if let err = error
//            {
//                print(err.localizedDescription)
//                completion(nil , err.localizedDescription)
//            }
//            else
//            {
//                completion("Data save Successfully" , nil)
//            }
//        }
//    }
//    func getAddOns(restaurantType : Restaturant, key: String ,itemKey: String  ,completion : @escaping (_ addOns: [addOnsModel]?) -> Void){
//        ref.child(restaurantType.rawValue).child(key).child("Item").child(itemKey).child("AddOns").observe(.value) { (snapshot) in
//
//            var addOnObject = [addOnsModel]()
//
//            for child in snapshot.children {
//
//                let snap = child as! DataSnapshot
//                if let value = snap.value as? [String : Any] {
//                    let name = value["name"] as! String
//                    let price = value["price"] as! String
//                    let object = addOnsModel(name: name, price: price, key: snap.key)
//                    addOnObject.append(object)
//                 }
//            }
//            completion(addOnObject)
//        }
//}
}
