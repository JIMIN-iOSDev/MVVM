//
//  MapViewController.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/11/25.
//

import UIKit
import MapKit
import SnapKit

final class MapViewController: UIViewController {
     
    private let mapView = MKMapView()
    private var restaurants = RestaurantList.restaurantArray
    private var filter: [Restaurant] = []
     
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupMapView()
        addRestaurantAnnotaion(filter: restaurants)
    }
     
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "지도"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "메뉴",
            style: .plain,
            target: self,
            action: #selector(rightBarButtonTapped)
        )
         
        view.addSubview(mapView)
         
        mapView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupMapView() {
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .none
         
        let seoulStationCoordinate = CLLocationCoordinate2D(latitude: 37.518820573402, longitude: 126.89986969097)
        let region = MKCoordinateRegion(
            center: seoulStationCoordinate,
            latitudinalMeters: 2000,
            longitudinalMeters: 2000
        )
        mapView.setRegion(region, animated: true)
    }
    
    private func addRestaurantAnnotaion(filter: [Restaurant]) {
        mapView.removeAnnotations(mapView.annotations)
        for restaurant in filter {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: restaurant.latitude, longitude: restaurant.longitude)
            annotation.title = restaurant.name
            annotation.subtitle = restaurant.address
            mapView.addAnnotation(annotation)
        }
    }
    
    private func filterCategory(category: String) {
        restaurants = RestaurantList.restaurantArray
        filter.removeAll()
        for item in restaurants {
            if item.category == category {
                filter.append(item)
            }
        }
        restaurants = filter
    }
     
    @objc private func rightBarButtonTapped() {
        let alertController = UIAlertController(
            title: "메뉴 선택",
            message: "원하는 옵션을 선택하세요",
            preferredStyle: .actionSheet
        )
        
        let alert1Action = UIAlertAction(title: "한식", style: .default) { _ in
            print("얼럿 1이 선택되었습니다.")
            self.filterCategory(category: "한식")
            self.addRestaurantAnnotaion(filter: self.restaurants)
            print("\(self.restaurants)")
        }
        
        let alert2Action = UIAlertAction(title: "일식", style: .default) { _ in
            print("얼럿 2가 선택되었습니다.")
            self.filterCategory(category: "일식")
            self.addRestaurantAnnotaion(filter: self.restaurants)
            print("\(self.restaurants)")
        }
        
        let alert3Action = UIAlertAction(title: "분식", style: .default) { _ in
            print("얼럿 3이 선택되었습니다.")
            self.filterCategory(category: "분식")
            self.addRestaurantAnnotaion(filter: self.restaurants)
            print("\(self.restaurants)")
        }
        
        let alert4Action = UIAlertAction(title: "전체보기", style: .default) { _ in
            print("얼럿 4가 선택되었습니다.")
            self.addRestaurantAnnotaion(filter: RestaurantList.restaurantArray)
            print("\(self.restaurants)")
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            print("취소가 선택되었습니다.")
        }
        
        alertController.addAction(alert1Action)
        alertController.addAction(alert2Action)
        alertController.addAction(alert3Action)
        alertController.addAction(alert4Action)
        alertController.addAction(cancelAction)
         
        present(alertController, animated: true, completion: nil)
    }
}
 
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        
        print("어노테이션이 선택되었습니다.")
        print("제목: \(annotation.title ?? "제목 없음")")
        print("부제목: \(annotation.subtitle ?? "부제목 없음")")
        print("좌표: \(annotation.coordinate.latitude), \(annotation.coordinate.longitude)")
        
        // 선택된 어노테이션으로 지도 중심 이동
        let region = MKCoordinateRegion(
            center: annotation.coordinate,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("어노테이션 선택이 해제되었습니다.")
    }
}
