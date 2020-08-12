//
//  DetailTableViewController.swift
//  MapKit1122
//
//  Created by 503-14 on 2018. 11. 23..
//  Copyright © 2018년 503-14. All rights reserved.
//

import UIKit
import MapKit
class MapDetailTableViewController: UITableViewController {
    
    //(2-3)상위 뷰 컨트롤러로부터 넘겨받을 데이터의 변수 선언
    var mapItems = [MKMapItem]()

    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    // MARK: - Table view data source
    //(2-4)섹션의 개수를 만드는 메소드
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    //(2-4)섹션별 행의 개수를 설정하는 메소드
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //기억이 안나면 self찍어서 찾기
        return self.mapItems.count
    }

    //(2-4)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //셀 만들기
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath) as! MapDetailTableViewCell
        //행번호에 해당하는 데이터를 찾아오기
        let row = self.mapItems[indexPath.row]
        
        //출력하기
        cell.lblName.text = row.name
        cell.lblPhone.text = row.phoneNumber

        return cell
    }
    
    //(2-8)셀을 선택했을 때 호출되는 메소드(ViewController가 아니라 TableViewController니까 override 붙여주기)
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //출력할 하위 뷰 컨트롤러 객체 생성
        let routeViewController = self.storyboard?.instantiateViewController(withIdentifier: "RouteViewController") as! RouteViewController
        //행 번호에 해당하는 데이터 넘겨주기
        routeViewController.detination = mapItems[indexPath.row]
        //이동
        self.navigationController?.pushViewController(routeViewController, animated: true)
        
    }

}
