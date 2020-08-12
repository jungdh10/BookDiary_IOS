import Foundation
import CoreData
import UIKit

class ReviewDAO{
    //AppDelegate에 있는 CoreData 사용을 위한 변수에 접근하는 변수 생성
    lazy var context : NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    //전체 데이터를 가져오는 메소드
    func fetch() -> [ReviewVO]{
        //리스트 생성
        var reviewList = [ReviewVO]()
        
        //요청 객체 생성
        let fetchRequest:NSFetchRequest<ReviewMO> = ReviewMO.fetchRequest()
        //2개 이상의 데이터를 가져올 때는 정렬 조건을 추가
        let regDateDesc = NSSortDescriptor(key: "regdate", ascending: false)
        fetchRequest.sortDescriptors = [regDateDesc]
        do{
            //데이터 가져오기
            let resultSet = try self.context.fetch(fetchRequest)
            //데이터 순회
            for record in resultSet{
                //1개의 데이터를 저장할 객체를 생성
                //VO변수=엔티티속성
                let data = ReviewVO()
                data.reviewId = record.reviewid
                data.bookname = record.bookname
                data.writing = record.writing
                data.writer = record.writer
                //날짜는 형변환해서 저장
                data.regdate = record.regdate! as Date
                //ID 저장
                data.objectID = record.objectID
                //image는 존재하면 변환해서 저장
                if let image = record.image as Data?{
                    data.image = UIImage(data: image)
                }
                //목록에 저장
                reviewList.append(data)
            }
        }catch let e as NSError{
            print("\(e.localizedDescription)")
        }
        
        return reviewList
    }
    
    //데이터를 삽입하는 메소드
    func insert(_ data:ReviewVO){
        //새로 저장할 객체를 생성
        let object = NSEntityDescription.insertNewObject(forEntityName: "Review", into: self.context) as! ReviewMO
        
        object.bookname = data.bookname
        object.writing = data.writing
        object.writer = data.writer
        object.regdate = data.regdate!
        if let image = data.image{
            //읽어온 이미지를 png 타입의 데이터로 변환해서 저장
            //최신 API
            object.image = image.pngData()
        }
        //데이터 저장
        do{
            try self.context.save()
        }catch let e as NSError{
            print("\(e.localizedDescription)")
        }
    }
    
    //데이터 삭제
    func delete(_ objectID: NSManagedObjectID) -> Bool{
        let object = self.context.object(with: objectID)
        self.context.delete(object)
        do{
            try self.context.save()
            return true
        }catch let e as NSError{
            print("\(e.localizedDescription)")
            return false
        }
    }
}
