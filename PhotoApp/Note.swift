import UIKit
import RealmSwift
import Realm
import Foundation

class Note : Object {
    dynamic var imageData = UIImageJPEGRepresentation(UIImage(named: "Camera"), 0.8)
    dynamic var setImage = false
    dynamic var latitude: Double = 0.0
    dynamic var longitude: Double = 0.0
    
    dynamic var title: String = ""
    dynamic var modificationDate = NSDate()
}