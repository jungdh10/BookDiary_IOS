
import Foundation
import UIKit
import CoreData

class JoinVO{
    var idIdx:Int?
    var id:String?
    var pw:String?
    var email:String?
    var nickname:String?
    var image:UIImage?
    
    //ReaderMO 인스턴스를 구별하기 위한 변수
    var objectID : NSManagedObjectID?
}
