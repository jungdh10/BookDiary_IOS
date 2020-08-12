
import UIKit

class ReviewInsertViewController: UIViewController {
    
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
    @IBOutlet weak var bookInsert: UITextField!
    @IBOutlet weak var writerInsert: UITextField!
    @IBOutlet weak var writingInsert: UITextView!
    
    @IBAction func save(_ sender: Any) {
        //guard self.contents.text.count == 0
        guard self.writingInsert.text.isEmpty == false else{
            let alert = UIAlertController(title: "텍스트 뷰에 내용을 작성해야 합니다.",message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)
            
            /*
            //POST
            let dataSync = DataSync()
            dataSync.insertData()
            print(dataSync)
            */
            return
        }
        
        //입력한 문자열이 있는 경우 데이터를 생성
        let review = ReviewVO()
        review.bookname = self.bookInsert.text
        review.writing = self.writingInsert.text
        review.image = self.imgInsert.image
        review.writer = self.writerInsert.text
        review.regdate = Date()
        //print("review:\(review)")
        
        //CoreData에 데이터 삽입
        let dao = ReviewDAO()
        dao.insert(review)
        //print(dao.fetch())
        
        //이전 뷰 컨트롤러로 돌아가기- popViewController는 UIViewController를 리턴
        self.navigationController?.popViewController(animated: true)
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

        
        writingInsert.delegate = self
    }

}
//UIImagePickerControllerDelegate
extension ReviewInsertViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    //이미지를 선택했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        self.imgInsert.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        picker.dismiss(animated:false)
    }
}

//UITextViewDelegate
extension ReviewInsertViewController : UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView){
        //입력된 문자열을 가져오기 - 사용을 편리하게 하기 위해서 형변환
        let writingInsert = textView.text as NSString
        //글자수가 15자가 넘으면 15 그렇지 않으면 글자수를 저장
        let length = (writingInsert.length > 15) ? 15 : writingInsert.length
        self.subject = writingInsert.substring(with:NSRange(location:0, length:length))
        self.navigationItem.title = subject
    }
}

