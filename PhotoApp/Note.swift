import Foundation
import RealmSwift

class Note : Object {
    dynamic var title: String = ""
    dynamic var content: String = ""
    dynamic var modificationDate = NSDate()
    
}