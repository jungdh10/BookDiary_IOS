
import UIKit
import Alamofire
class SearchTableViewController : UITableViewController {
    
    //파싱한 결과를 저장할 List 변수 - 지연생성 이용
    //지연생성 - 처음부터 만들어두지 않고 처음 사용할 때 생성
    lazy var list : [SearchVO] = {
        var datalist = [SearchVO]()
        return datalist
    }()
    
    //텍스트필드 변수와 메소드
    @IBOutlet weak var tf: UITextField!
    
    override func viewDidLoad(){
        super.viewDidLoad()

        tf.delegate = self
    }
    /*
    //화면에 뷰가 보여질 때 호출되는 메소드
    override func viewDidAppear(_ animated: Bool) {
        //추상 메소드가 아니면 상위 클래스의 메소드를 호출하고 기능 추가
        super.viewDidAppear(animated)
        
    }
 */
    
    //그룹 별 행의 개수를 설정하는 메소드
    //TableViewController의 경우는 이 메소드도 없으면 1을 리턴한 것으로 간주
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    //셀의 모양을 만드는 메소드 - 필수
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //사용자 정의 셀 만들기
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        //행번호에 해당하는 데이터 찾기
        let book = self.list[indexPath.row]
        print(book)
        //데이터 출력
        cell.lblTitle.text = book.title!
        cell.lblWriter.text = book.authors!
        cell.thumbnailImage.image = book.image
        
        return cell
    }
    //셀의 높이를 설정하는 메소드
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath:
        IndexPath) -> CGFloat{
        return 80
    }
}

extension SearchTableViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        //검색할 때 클리어를 해줘야 다음에 검색 시 초기화
        list.removeAll()
        
        let bookSearch = tf.text

        guard bookSearch?.isEmpty == false else{
            let alert = UIAlertController.init(title: "책 이름을 입력하세요.", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)
            //TextField가 Bool타입 이니까 0,1아닌 true,false로 리턴
            return false
        }
        
        //URL을 생성해서 다운로드 받기
        //다운로드 받을 URL 만들기
        let url = "https://dapi.kakao.com/v3/search/book?target=title&query=\(bookSearch!)"
        //print(url)
        //url에 한글이 있을 시 인코딩(한글로 검색 가능하게 설정)
        let encoding = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let apiURI : URL! = URL(string: encoding!)
        
        let request = Alamofire.request(apiURI, method: .get, headers: ["Authorization": "KakaoAK 311288dc5e49578a3cb237223baf684a"])
        request.responseJSON{response in
            //print(response.result.value!)
            
            let result = response.result.value! as! NSDictionary
            //print(result)
            let document = result["documents"] as! NSArray
            //print(document)
            
            for index in 0...(document.count - 1){
                let documents = document[index] as! NSDictionary
                
                var book = SearchVO()
                book.title = documents["title"] as! String
                let ar = documents["authors"] as! NSArray
                for temp in ar{
                    temp as! String
                    book.authors = temp as! String
                }
                book.linkUrl = documents["url"] as! String
                book.thumbnailImage = documents["thumbnail"] as! String
                
                //이미지 URL을 가지고 이미지 데이터를 다운로드 받아서 저장
                let url = URL(string: book.thumbnailImage!)
                //데이터 다운로드
                let imageData = try! Data(contentsOf: url!)
                //저장
                book.image = UIImage(data:imageData)
                
                self.list.append(book)
            }
            
            //print(self.list)
            //테이블 뷰 재출력
            self.tableView.reloadData()
            
            self.navigationItem.title="검색 목록 보기"
            //== self.title="검색 목록 보기"
        }
        
        //true를 주면 해야할 일을 하고 false하면 해야할 일을 하지 않음
        return true
    }
    
    
    
}
