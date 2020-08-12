
import UIKit
//스위프트에서 import는 namespace를 가져오는 역할(라이브러리를 가져오는 것이 아님)
//자바에서 import는 이름을 줄여 쓰기 위한 역할
//c에서 include는 파일의 내용을 가져오는 역할
//c나 swift에서는 import나 inclide를 안하면 그 기능을 사용할 수 없음
//자바는 import하지 않고 전체 이름을 이용해서 사용할 수 없음
//html에서 script src도 c언어의 include 개념입니다.


//Alamofire는 URL 통신을 쉽게 할 수 있도록 해주는 외부라이브러리로 항상 설치해서 사용해야 합니다.
import Alamofire
import CoreData
class ViewController: UIViewController {
    
    //로그인 버튼 변수
    @IBOutlet weak var loginbtn: UIButton!
    
    //AppDelegate 객체에 대한 참조 변수
    var appDelegate : AppDelegate!
    
    //로그인 버튼 메소드
    @IBAction func login(_ sender: Any) {
        if loginbtn.title(for: .normal) == "로그인"{
            
            //로그인 대화상자 생성
            //.alert은 가운데 띄우고 , ActionSheet는 아래서 위로 올라오는 대화상자
            let alert = UIAlertController(title: "로그인", message: nil, preferredStyle: .alert)
            //대화상자에 입력을 받을 수 있는 텍스트필드를 두개 추가
            alert.addTextField(){(tf) in tf.placeholder = "아이디를 입력하세요"}
            alert.addTextField(){(tf) in tf.placeholder = "비밀번호를 입력하세요"
                tf.isSecureTextEntry = true
            }
            //대화상자 버튼만들기
            //(_) in 하고(로그인하면) 어떤 일을 할 것인지 작성
            alert.addAction(UIAlertAction.init(title: "취소", style: .cancel))
            alert.addAction(UIAlertAction.init(title: "로그인", style: .default){ (_) in
                //무조건 배열, 입력한 id 와 pw를 가져오기
                var id = alert.textFields![0].text
                var password = alert.textFields![1].text
                //웹에 요청
                let request = Alamofire.request("http://172.30.1.17:8080/bookdiary/reader/login?id=\(id!)&password=\(password!)", method:.get, parameters:nil)
                
                //결과를 사용-result에 결과가 들어있다.
                request.responseJSON{
                    response in
                    //결과 확인
                    //print(response.result.value!)
                    //읽어오기
                    if let jsonObject = response.result.value as? [String:Any]{
                        //result 키의 내용 가져오기
                        //id만 꺼내서 null인지 확인
                        let result = jsonObject["result"] as! NSDictionary
                        let id = result["id"] as! NSString
                        if id == "NULL"{
                            self.title = "로그인 실패"
                        }else{
                            //로그인 성공했을 때 로그인 정보 저장
                            self.appDelegate.id = id as String
                            self.appDelegate.email =
                                (result["email"] as! NSString) as String
                            self.appDelegate.nickname =
                                (result["nickname"] as! NSString) as String
                            
                            
                            //self.appDelegate.image = (result["image"] as! NSString) as String
                            
                            
                            self.title = "\(self.appDelegate.nickname!)님 로그인"
                            
                            /*
                             //(2)이미지에 저장된 데이터로 서버에서 이미지를 다운로드 받아 타이틀로 설정
                             let request = Alamofire.request("http://172.30.1.55:8080/bookdiary/reviewimage/\(self.appDelegate.image!)", method:.get, parameters:nil)
                             request.response{
                             response in
                             //다운로드 받은 데이터를 가지고 Image 생성
                             let image = UIImage(data:response.data!)
                             //이미지를 출력하기 위해서 ImageView 만들기
                             let imageView = UIImageView(frame:CGRect(x:0, y:0, width:40, height:40))
                             imageView.contentMode = .scaleAspectFit
                             imageView.image = image
                             //네비게이션 바에 배치
                             self.navigationItem.titleView = imageView
                             }
                             */
                            
                            self.loginbtn.setTitle("로그아웃", for:.normal)
                        }
                    }
                }
            })
            //로그인 대화상자를 출력
            self.present(alert, animated: true)
            
        }else{
            //로그인 정보를 삭제해서 로그아웃시키기
            appDelegate.id = nil
            appDelegate.email = nil
            appDelegate.nickname = nil
            //appDelegate.image = nil
            //네비게이션 바의 타이틀과 버튼의 타이틀을 변경
            //네비게이션의 타이틀
            self.title="로그인이 안된 상태"
            //버튼의 타이틀 - 다시 로그인으로 변경되야 함
            loginbtn.setTitle("로그인", for: .normal)
        }
    }
    
    
    @IBAction func sidebtn(_ sender: Any) {
        if loginbtn.title(for: .normal) == "로그아웃"{
            
            if let revealVC = self.revealViewController(){
                let btn = UIBarButtonItem()
                btn.image = UIImage(named:"sidemenu.png")
                btn.target = revealVC
                btn.action = #selector(revealVC.revealToggle(_:))
                self.navigationItem.leftBarButtonItem = btn
                self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
            }
        }else if loginbtn.title(for: .normal) == "로그인"{
            let alert = UIAlertController(title:"로그인 하세요.", message:nil, preferredStyle:.alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated:false)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //AppDelegate에 대한 참조를 생성
        appDelegate = UIApplication.shared.delegate as? AppDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //swift에서 override할때 super 불러주기
        super.viewWillAppear(animated)
        //로그인 여부 확인
        if appDelegate.id == nil{
            self.title="로그인이 되어 있지 않음"
            self.loginbtn.setTitle("로그인", for: .normal)
        }else{
            self.title="로그인 된 상태"
            self.loginbtn.setTitle("로그아웃", for: .normal)
        }
        //이렇게하면 "로그인"과 "로그아웃"글자가 togle
    }
    
}

