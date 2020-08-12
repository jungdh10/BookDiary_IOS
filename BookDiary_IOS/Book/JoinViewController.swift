
import UIKit

class JoinViewController: UIViewController {
    
    //이미지피커의 타입을 매개변수로 받아서 이미지 피커를 출력해주는 사용자 정의 메소드
    func presentPicker(source : UIImagePickerController.SourceType){
        //유효한 소스 타입이 아니면 중단
        guard UIImagePickerController.isSourceTypeAvailable(source) == true else{
            let alert = UIAlertController(title:"사용할 수 없는 타입입니다.", message:nil, preferredStyle:.alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated:false)
            return
        }
        
        //이미지 피커 출력
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = source
        
        self.present(picker, animated:true)
    }
    
    //텍스트를 입력하는 도중에 호출되는 메소드
    var subject : String!
    
    
    @IBOutlet weak var imgInsert: UIImageView!
    @IBOutlet weak var idInsert: UITextField!
    @IBOutlet weak var pwInsert: UITextField!
    @IBOutlet weak var emailInsert: UITextField!
    @IBOutlet weak var nickInsert: UITextField!
    
    
    @IBAction func save(_ sender: Any) {
        guard self.idInsert.text?.isEmpty == false else{
            let alert = UIAlertController(title: "아이디를 입력하세요.",message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)
            return
        }
        /*
        if JoinDAO.idCheck(self.idInsert.text) == true{
            let alert = UIAlertController(title: "사용중인 아이디입니다.",message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)
            
        }
 */
        
        guard self.pwInsert.text?.isEmpty == false else{
            let alert = UIAlertController(title: "비밀번호를 입력하세요.",message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)
            return
        }
        guard self.nickInsert.text?.isEmpty == false else{
            let alert = UIAlertController(title: "닉네임을 입력하세요.",message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)
            return
        }
        
        //입력한 문자열이 있는 경우 데이터를 생성
        let join = JoinVO()
        join.id = self.idInsert.text
        join.pw = pwInsert.text
        join.email = emailInsert.text
        join.nickname = nickInsert.text
        join.image = imgInsert.image
        
        //CoreData에 데이터 삽입
        let dao = JoinDAO()
        dao.insert(join)
        print(dao.fetch())
        
        /*
        //가입성공 대화상자
        let alert = UIAlertController(title: "가입되었습니다.",message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default){
            (_) in
            //이전 뷰 컨트롤러로 돌아가기
            self.navigationController?.popViewController(animated: true)
        })
 */
        
    }
    
    @IBAction func pick(_ sender: Any) {
        let select = UIAlertController(title:"이미지를 가져올 곳을 선택하세요!", message:nil, preferredStyle:.actionSheet)
        select.addAction(UIAlertAction(title:"카메라", style:.default){
            (_) in self.presentPicker(source:.camera)
        })
        select.addAction(UIAlertAction(title:"앨범", style:.default){
            (_) in self.presentPicker(source:.savedPhotosAlbum)
        })
        select.addAction(UIAlertAction(title:"사진 라이브러리", style:.default){
            (_) in self.presentPicker(source:.photoLibrary)
        })
        self.present(select, animated:true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    

    

}
//UIImagePickerControllerDelegate
extension JoinViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //이미지를 선택했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        self.imgInsert.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        picker.dismiss(animated:false)
    }
}
