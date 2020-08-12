
import UIKit

class ReviewDetailViewController: UIViewController {


    @IBOutlet weak var imgDetail: UIImageView!
    @IBOutlet weak var bookDetail: UILabel!
    @IBOutlet weak var writerDetail: UILabel!
    @IBOutlet weak var reviewDetail: UILabel!
    
    //데이터를 넘겨받을 변수를 인스턴스 변수로 선언
    //처음에는 데이터가 없으니까?붙인다. - 이렇게 선언하면 나중에 사용할 때는 옵셔널을 벗겨서 사용(viewDidLoad()에 review?.)
    var review : ReviewVO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgDetail.image = review?.image
        bookDetail.text = review?.bookname
        writerDetail.text = review?.writer
        reviewDetail.text = review?.writing
        
        navigationItem.title = "상세보기"

    }
    

    

}
