
import Foundation
import UIKit
import CoreData

class JoinDAO{
    
    //AppDelegate에 있는 CoreData 사용을 위한 변수에 접근하는 변수 생성
    lazy var context : NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    //전체 데이터를 가져오는 메소드
    func fetch() -> [JoinVO]{
        //리스트 생성
        var joinList = [JoinVO]()
        
        //요청 객체 생성
        let fetchRequest:NSFetchRequest<ReaderMO> = ReaderMO.fetchRequest()
        do{
            //데이터 가져오기
            let resultSet = try self.context.fetch(fetchRequest)
            //데이터 순회
            for record in resultSet{
                //1개의 데이터를 저장할 객체를 생성
                //VO변수=엔티티속성
                let data = JoinVO()
                data.id = record.id
                //data.pw = record.password
                data.email = record.email
                data.nickname = record.nickname
                //ID 저장
                data.objectID = record.objectID
                //image는 존재하면 변환해서 저장
                if let image = record.image as Data?{
                    data.image = UIImage(data: image)
                }
                //목록에 저장
                joinList.append(data)
            }
        }catch let e as NSError{
            print("\(e.localizedDescription)")
        }
        return joinList
    }
    
    //데이터를 삽입하는 메소드
    func insert(_ data:JoinVO){
        //새로 저장할 객체를 생성
        let object = NSEntityDescription.insertNewObject(forEntityName: "Reader", into: self.context) as! ReaderMO
        
        object.id = data.id
        object.password = data.pw
        object.email = data.email
        object.nickname = data.nickname
        if let image = data.image{
            //읽어온 이미지를 png 타입의 데이터로 변환해서 저장
            object.image = image.pngData()
        }
        //데이터 저장
        do{
            try self.context.save()
        }catch let e as NSError{
            print("\(e.localizedDescription)")
        }
    }
    
    
    //전체 데이터를 가져오는 메소드
    func idCheck(_ joinID: JoinVO) -> Bool{
        //let idInsert = JoinViewController().idInsert.text
        
        //요청 객체 생성
        let fetchRequest:NSFetchRequest<ReaderMO> = ReaderMO.fetchRequest()
        do{
            //데이터 가져오기
            let resultSet = try self.context.fetch(fetchRequest)
            //데이터 순회
            for record in resultSet{
                let data = JoinVO()
                data.id = record.id
                if data.id == JoinVO().id {
                    print("있는 id일 경우")
                }
            }
        }catch let e as NSError{
            print("\(e.localizedDescription)")
        }
        return true
    }
 
    
}
