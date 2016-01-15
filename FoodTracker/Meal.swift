//
//  Meal.swift
//  FoodTracker
//
//  Created by Shawn  on 14/01/16.
//  Copyright © 2016 Shawn . All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
    
    var name : String
    var photo : UIImage?
    var rating : Int
    
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    init?(name:String, photo: UIImage?,rating:Int){
        
        self.name = name
        self.photo = photo
        self.rating = rating
        
        super.init()
        
        if name.isEmpty || rating < 0{
            return nil
        }
    }
    
    override var description:String{
        return "\(name) met als rating \(rating)"
    }
    
    struct PropertyKey {
        static let nameKey = "name"
        static let photokey = "photo"
        static let ratingKey = "rating"
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photokey)
        aCoder.encodeObject(rating, forKey: PropertyKey.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photokey) as! UIImage
        let rating = aDecoder.decodeObjectForKey(PropertyKey.ratingKey) as! Int
        
        self.init(name: name, photo: photo, rating: rating)
    }
}
