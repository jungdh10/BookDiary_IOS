import Foundation
import Alamofire
import CoreData

class DataSync{
    //CoreData를 사용하려면 코어데이터에 접근하기 위한 포인터가 필요
    //코어데이터에 접근하는 포인터 변수 생성
    lazy var context:NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    //날짜를 사용하는 경우는 날짜 포맷을 맞춰주는 메소드를 별도로 만들어 두는 것이 좋다.
    //DataSync <-> ios나 Android 이 방식의 통신이 안됩니다.
    //그렇기 때문에 DataSync <-> RestAPI <-> ios나 Android 이렇게 통신한다.
    //그래서 중간에 변환을 해서 맞춰줘야 한다.
    
    //날짜를 데이터베이스에 yyyy-MM-dd HH:mm:ss 형식으로 저장
    //서버와 클라이언트 모두 저 형식에 맞추어서 데이터를 전송하고 받아야 한다.
    
    //문자열을 IOS의 데이터로 변환하는 방법 String ->Date
    //String으로 받고 리턴타입은 Date
    func stringToDate(_ value:String) -> Date{
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df.date(from: value)!
    }
    
    //이제 반대로 Date -> String
    func dateToString(_ value:Date) -> String{
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return df.string(from: value as Date)
    }
    
    //서버에서 데이터를다운로드 받아서 CoreData에 저장하는 메소드
    func downloadData(){
        //이 메소드를 한 번 호출해서 데이터를 다운로드 받으면 앱을 지우기 전까지는 다시는 다운로드 받지 않도록 생성
        //게임 애플리케이션에서 초기 데이터 가져올 때 사용하는 방법
        //UserDefaults : 앱의 설정 파일
        //앱을 지우기 전까지는 내용을 보존
        let userDefaults = UserDefaults.standard
        //특정 키의 값이 nil 이 아니면 리턴
        //guard는 조건에 맞지 않으면 작업을 수행하지 않도록 하기 위해서 사용하는 경우가 많습니다.
        guard userDefaults.value(forKey:"download") == nil else{
            return
        }
        
        //다운로드 받을 서버의 url 만들기
        let url = "http://172.30.1.30:8080/bookdiary/review/reviewlist"
        //요청보내기(다운로드받을 주소, 메소드결정, 인코딩, 필요하면 헤더를 준다.)
        let get = Alamofire.request(url, method:.get, encoding:JSONEncoding.default, headers:nil)
        //응답 처리
        //json데이터니까 get.responseJSON
        get.responseJSON{
            res in
            //데이터 전체를 디셔너리 로 변경
            guard let jsonObject = res.result.value as? NSDictionary else{return}
            //reviews 키의 데이터를 list로 변환
            guard let list = jsonObject["reviews"] as? NSArray else{return}
            //배열 순회(이렇게 하면 하나하나의 항목이오고 이것을 딕셔너리로 변환한다.)
            for item in list{
                //하나 하나의 항목을 디셔너리로 변경
                //주는건 Date고 웹에서 주는건 String이기 때문에
                //데이터 다운로드 받는 방법 object.image = try! Data(contentsOf:url!)
                guard let record = item as? NSDictionary else{return}
                //CoreData의 자료형인 ReviewMO 객체 만들기
                let object = NSEntityDescription.insertNewObject(
                    forEntityName:"Review", into:self.context) as! ReviewMO
                //데이터를 저장(Oracle은 "대문자" mysql은 "소문자")
                object.reviewid = (record["reviewid"] as! Int32)
                object.bookname = (record["bookname"] as! String)
                object.writing = (record["writing"] as! String!)
                object.writer = (record["writer"] as! String)
                object.regdate = self.stringToDate(record["regdate"] as! String)
                //image가 Binary Data이기 때문에 다운로드 받아서 저장해준 것
                if let image = record["image"] as? String{
                    //서버에서 이미지가 없으면 공백으로 저장했으니까
                    if image != " "{
                        let url = URL(string:"http://172.30.1.30:8080/bookdiary/reviewimage/\(image)")
                        object.image = try! Data(contentsOf:url!)
                    }
                }
            }
            
            //do는 예외처리를 하겠다 try!는 예외처리를 안하겠다는 것
            //데이터를 코어 데이터에 저장
            do{
                try self.context.save()
            }catch let e as NSError{
                print("\(e.localizedDescription)")
            }
            //다운로드 받았다는 사실을 저장
            userDefaults.setValue(true, forKey:"download")
                  
        }
    }
    /*
    func insertData(){
        let reviewInsert = ReviewInsertViewController()
        let parameter = ["bookname":"\(reviewInsert.bookInsert.text)",
            "writer":"\(reviewInsert.writerInsert.text)",
            "writing":"\(reviewInsert.writingInsert.text)",
            "image":"\(reviewInsert.imgInsert.image)"]

        let url = "http://172.30.1.30:8080/bookdiary/review/reviewinsert"
        let post = Alamofire.request(url, method: .post, parameters: parameter, encoding: JSONEncoding.default, headers: nil)
        .responseJSON{ response in
            switch response.result{
            case .success:
                print(response)
            case .failure:
                print("Error")
            }
           
            
            
            
        }
    }
 */
    
}
