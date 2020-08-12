
import UIKit

class SideBarVC: UITableViewController {
    let titles = ["감상문 작성", "도서 검색", "내 주변 서점",
                  "도서 뉴스", "계정관리", "설정"]
    let icons = [UIImage(named: "bookreport.png"),
                 UIImage(named: "search.png"),
                 UIImage(named: "map.png"),
                 UIImage(named: "news.png"),
                 UIImage(named: "id.png"),
                 UIImage(named: "set.png")]
    
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let profileImage = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        headerView.backgroundColor = UIColor.darkGray
        self.tableView.tableHeaderView = headerView
        
        nameLabel.frame = CGRect(x: 70, y: 15, width: 120, height: 30)
        nameLabel.text = "dahye"
        nameLabel.textColor = UIColor.white
        self.nameLabel.backgroundColor = UIColor.clear
        headerView.addSubview(nameLabel)
        
        emailLabel.frame = CGRect(x: 70, y: 30, width: 140, height: 30)
        emailLabel.text = "dahye@gmail.com"
        emailLabel.textColor = UIColor.white
        self.emailLabel.backgroundColor = UIColor.clear
        headerView.addSubview(emailLabel)
        
        let defaultProfile = UIImage(named: "account.jpg")
        profileImage.image = defaultProfile
        profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        headerView.addSubview(profileImage)
        //네모난 이미지 뷰를 둥글게 만들기
        profileImage.layer.cornerRadius = (profileImage.frame.width/2)
        profileImage.layer.borderWidth = 0
        profileImage.layer.masksToBounds = true
        headerView.addSubview(profileImage)
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let id = "MenuCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        
        
        return cell
    }

    //셀의 높이를 설정해주는 메소드 재정의
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 80
    }
    
    //셀의 선택했을 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let uv = self.storyboard?.instantiateViewController(withIdentifier:"ReviewViewController") as! ReviewViewController
            //사이드 바의 네비게이션 컨트롤러를 찾아오기
            let target = self.revealViewController().frontViewController as! UINavigationController
            //화면 출력
            target.pushViewController(uv, animated:true)
            //사이드 바 제거
            self.revealViewController().revealToggle(self)
            
        }else if indexPath.row == 1{
                let uv = self.storyboard?.instantiateViewController(withIdentifier:"SearchTableViewController") as! SearchTableViewController
                let target = self.revealViewController().frontViewController as! UINavigationController
                //화면 출력
                target.pushViewController(uv, animated:true)
                //사이드 바 제거
                self.revealViewController().revealToggle(self)
            
            
        }else if indexPath.row == 2{
            let uv = self.storyboard?.instantiateViewController(withIdentifier:"MapViewController") as! MapViewController
            let target = self.revealViewController().frontViewController as! UINavigationController
            //화면 출력
            target.pushViewController(uv, animated:true)
            //사이드 바 제거
            self.revealViewController().revealToggle(self)
            
        }else if indexPath.row == 3{
            let uv = self.storyboard?.instantiateViewController(withIdentifier:"NewsTableViewController") as! NewsTableViewController
            let target = self.revealViewController().frontViewController as! UINavigationController
            //화면 출력
            target.pushViewController(uv, animated:true)
            //사이드 바 제거
            self.revealViewController().revealToggle(self)
            
        }else if indexPath.row == 4{
            let uv = self.storyboard?.instantiateViewController(withIdentifier:"ProfileVC") as! ProfileVC
            let target = self.revealViewController().frontViewController as! UINavigationController
            //화면 출력
            target.pushViewController(uv, animated:true)
            //사이드 바 제거
            self.revealViewController().revealToggle(self)
        }
    }
}
