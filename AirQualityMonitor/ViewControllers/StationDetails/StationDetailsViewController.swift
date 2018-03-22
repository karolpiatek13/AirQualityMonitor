//
//  StationDetailsViewController.swift
//  AirQualityMonitor
//
//  Created by Karol on 10.01.2018.
//  Copyright © 2018 KarolPiatek. All rights reserved.
//

import RxSwift
import MapKit

class StationDetailsViewController: UIViewController {

    @IBOutlet weak var stationNameLabel: UILabel!
    @IBOutlet weak var stationAddressLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var viewModel: StationDetailsViewModel!
    let bag = DisposeBag()
    
    init(viewModel: StationDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: StationDetailsViewController.typeName, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(goBack))
    }
    
    func bindData() {
        viewModel.stationName.bind(to: stationNameLabel.rx.text).disposed(by: bag)
        viewModel.stationAddress.bind(to: stationAddressLabel.rx.text).disposed(by: bag)
        viewModel.station.subscribe(onNext: { station in
            self.setMapView(station: station)
        }).disposed(by: bag)
    }
    
    func setMapView(station: Station) {
        guard let lat = station.gegrLat, let lon = station.gegrLon,
            let title = station.stationName, let city = station.city?.name else {
                return
        }
        var subTitle: String
        if let street = station.addressStreet {
            subTitle = street + ", " + city
        } else {
            subTitle = city
        }
        let coordinate = CLLocationCoordinate2D(latitude: Double(lat) ?? 0.0, longitude: Double(lon) ?? 0.0)
        let annotation = self.getAnnotation(coordinate: coordinate, title: title, subTitle: subTitle)
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
        setVisibleRegion(coordinate: coordinate)
    }
    
    func getAnnotation(coordinate: CLLocationCoordinate2D, title: String, subTitle: String) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        let cllLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(cllLocation, completionHandler: { (placemarks, error) -> Void in
            annotation.title = title
            annotation.subtitle = subTitle
        })
        return annotation
    }
    
    func setVisibleRegion(coordinate: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, 500, 500)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    @objc
    func goBack() {
        viewModel.flowDelegate.backToParent()
    }
}
