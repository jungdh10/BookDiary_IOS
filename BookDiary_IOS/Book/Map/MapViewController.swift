//
//  ViewController.swift
//  MapKit1122
//
//  Created by 503-14 on 2018. 11. 22..
//  Copyright © 2018년 503-14. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    //(2-5)sent Action으로 연결
    @IBAction func moveDetail(_ sender: Any) {
        let detailTableViewController =
            self.storyboard?.instantiateViewController(withIdentifier: "MapDetailTableViewController") as! MapDetailTableViewController
        detailTableViewController.mapItems = self.matchingItems
        self.title = "MainView"
       //출력
    self.navigationController?.pushViewController(detailTableViewController, animated: true)
    }
    //위치 정보 사용 객체의 변수 선언
    var locationManager : CLLocationManager!

    @IBOutlet weak var mapView: MKMapView!
    //(2)검색결과를 저장할 배열 객체
    var matchingItems : [MKMapItem] = [MKMapItem]()
    
    @IBAction func type(_ sender: Any) {
        if mapView.mapType == .satellite{
            mapView.mapType = .standard
        }else{
            mapView.mapType = .satellite
        }
    }
    
    @IBAction func zoom(_ sender: Any) {
        //맵 뷰에서 현재 사용자의 위치 가져오기
        let userLocation = mapView.userLocation
        //출력 영역 만들기
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 2000, longitudinalMeters: 2000)
        //맵 뷰에 설정
        mapView.setRegion(region, animated: true)
    }
   
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //위치정보 사용 객체 생성
        locationManager = CLLocationManager()
        //위치정보 사용 권한을 묻는 대화상자 출력
        locationManager?.requestWhenInUseAuthorization()
        //맵 뷰에 현재 위치를 출력
        mapView.showsUserLocation = true
    }
    
    //(2-1)
    func performSearch(){
        //기존 검색 내용 삭제
        matchingItems.removeAll()
        //검색 객체 만들기
        let request = MKLocalSearch.Request()
        //검색어와 검색 영역 설정 "서점"
        request.naturalLanguageQuery = tf.text
        //맵뷰의 영역을 검색 영역에 넣기
        request.region = mapView.region
        //검색 요청 객체 생성
        let search = MKLocalSearch(request: request)
        //검색 요청과 핸들러 - 끝나고 호출되는 일
        search.start(completionHandler:{(response:MKLocalSearch.Response!, error:Error!) in
            if error != nil{
                print("검색 중 에러")
            }else if response?.mapItems.count == 0{
                print("검색된 결과가 없음")
            }else{
                print("검색 성공")
                //전체 데이터를 순회하면서 배열에 하나씩 집어넣기
                for item in response.mapItems as [MKMapItem]{
                    //데이터를 한 개씩 배열에 저장
                    self.matchingItems.append(item as MKMapItem)
                    //각각을 맵에 출력
                    let annotation = MKPointAnnotation()
                    //어노테이션 정보 생성
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    annotation.subtitle = item.phoneNumber
                    self.mapView.addAnnotation(annotation)
                    
                }
            }
        })
    }
    
    //(2-2)텍스트필드 변수
    @IBOutlet weak var tf: UITextField!
    //텍스트필드에 검색어 입력 후 리턴키 눌렀을 때
    @IBAction func search(_ sender: Any) {
        //키보드를 제거
        let textField = sender as! UITextField
        textField.resignFirstResponder()
        //맵 뷰의 어노테이션 제거
        mapView.removeAnnotations(mapView.annotations)
        //검색 메소드 호출
        performSearch()
    }
}

//사용자가 움직이면 지도도 따라 움직이도록 설정
extension MapViewController : MKMapViewDelegate{
    //사용자의 위치가 변경된 경우 호출되는 메소드
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        mapView.centerCoordinate = userLocation.location!.coordinate
    }
}

