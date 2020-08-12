
import UIKit
import WebKit
class NewsDetailViewController: UIViewController {
    
    //웹 주소를 넘겨받을 변수
    //var address : [String] = [String]()
    var address : String?

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let addr = address{
            //URL 객체 생성
            let webURL = URL(string:addr)
            //Request 객체 생성
            let urlRequest = URLRequest(url:webURL!)
            //웹 뷰가 로딩
            webView.load(urlRequest)
        }
    }

}
