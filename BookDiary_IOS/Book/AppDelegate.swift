
import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var joinList = [JoinVO]()
    var reviewList = [ReviewVO]()
    
    //!나 ?는 나중에 값을 저장할 수 있도록 선언(!나 ?가 없으면 무조건 값을 가지고 있어야 합니다.)
    var id : String!
    var email : String!
    var nickname : String!
    var image : String!

    //애플리케이션이 시작될 때 호출되는 메소드
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let dataSync = DataSync()
        //비동기적으로 실행 - 스레드
        DispatchQueue.global(qos: .background).async{
            dataSync.downloadData()
        }
        
        return true
    }

    //앱이 실행을 종료할 때 호출되는 메소드
    func applicationWillResignActive(_ application: UIApplication) {
    }

    //앱이 백그라운드로 진행하기 직전에 호출되는 메소드
    //앱을 종료하는 경우도 있지만 전화 등의 인터럽트가 방생한 경우에도 호출
    //실행 중에 필요한 데이터를 저장해두는 곳(음악 재생의 경우 재생 지점을 저장)
    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    //앱이 포그라운드로 갈 떄 호출되는 메소드(백그라운드에서 포그라운드로 갈 때)
    //앞에서 저장한 데이터를 가지고 작업을 계속 수행
    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    //앱이 다시 포그라운드에 진입한 후 호출되는 메소드
    //UI갱신을 한다. 여기서 viewDidLoad를 강제로 호출해서 데이터를 갱신해서 출력하는 경우가 많다.
    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    //앱이 종료될 떄 호출되는 메소드
    //중요한 데이터를 서버에 저장하는 코드를 작성하는 곳
    func applicationWillTerminate(_ application: UIApplication) {
        //이 코드는 코어데이터를 사용하는 프로젝트에서만 존재하는 코드인데 코어데이터의 모든 내용을 반영
        self.saveContext()
    }

    // MARK: - Core Data stack
    //이 코드들도 코어데이터 프로젝트에만 존재하는 코드
    //코어데이터에 접근하기 위한 포인터를 만드는 코드
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Book")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    //코어 데이터의 내용을 저장하는 메소드 -없어도 코어데이터쓰는데 문제없다. 그때 그때 쓰면 되니까
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
