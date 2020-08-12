
import UIKit

class ReviewViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
 
    @IBOutlet weak var collectionView: UICollectionView!
    
    //바버튼 아이템을 누르면 호출되는 메소드
    @objc func add(_ barButtonItem: UIBarButtonItem){
        //화면 출력하기
        let reviewInsertViewController = self.storyboard?.instantiateViewController(withIdentifier: "ReviewInsertViewController") as! ReviewInsertViewController
        reviewInsertViewController.navigationItem.title = "감상문 작성"
        self.navigationController?.pushViewController(reviewInsertViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션 바의 오른쪽에  + 버튼 배치
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(ReviewViewController.add(_:)))
        
        //컬렉션 뷰의 출력과 이벤트 핸들링을 담당할 인스턴스 지정
        collectionView.delegate = self
        collectionView.dataSource = self
    
    }
    
    //뷰가 출력될 때 마다 호출되는 메소드
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //데이터를 코어데이터에서 가져오기
        let dao = ReviewDAO()
        self.appDelegate.reviewList = dao.fetch()
        self.collectionView.reloadData()
    }
 
 
 
}
//Mark: collectionView의 delegate, dataSource

extension ReviewViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return appDelegate.reviewList.count
    }
    
    //출력할 셀을 만들어주는 cellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let data = appDelegate.reviewList[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCollectionViewCell", for: indexPath) as! ReviewCollectionViewCell

        cell.bookname.text = data.bookname
        cell.imgView.image = data.image
        //날짜를 원하는 형식의 문자열로 만들어주는 객체를 생성
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.regdate.text = formatter.string(from: data.regdate!)

        return cell
    }
    
    //셀 선택 시 didSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){

        let alert = UIAlertController(title: "클릭하세요!", message: "", preferredStyle: .actionSheet)
         alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "상세보기", style: .default){(_) in
            let review = self.appDelegate.reviewList[indexPath.row]
            let reviewDatilViewController = self.storyboard?.instantiateViewController(withIdentifier: "ReviewDetailViewController") as! ReviewDetailViewController
            reviewDatilViewController.review = review
            self.navigationController?.pushViewController(reviewDatilViewController, animated: true)
        })
        alert.addAction(UIAlertAction(title: "삭제하기", style: .default){(_) in
            //행번호에 해당하는 데이터 찾아오기
            let data = self.appDelegate.reviewList[indexPath.row]
            let dao = ReviewDAO()
            //CoreData에서 삭제
            if dao.delete(data.objectID!){
                //메모리에서도 삭제
                self.appDelegate.reviewList.remove(at:indexPath.row)
                //행번호에 해당하는 데이터를 삭제하는 애니메이션 수행
                self.collectionView.deleteItems(at: [indexPath])
                //self.tableView.deleteRows(at: [indexPath], with: .left)
            }
        })
        self.present(alert, animated: true)
        
    }

    
}
