import Foundation
import UIKit
import CoreData

class ReviewVO{
    var reviewId:Int32?
    //var reviewIdx:Int?
    var bookname:String?
    var writing:String?
    var writer:String?
    var image:UIImage?
    var regdate:Date?
    
    //ReviewMO 인스턴스를 구별하기 위한 변수
    var objectID : NSManagedObjectID?
}
