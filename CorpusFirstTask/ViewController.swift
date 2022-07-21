//
//  ViewController.swift
//  CorpusFirstTask
//
//  Created by Vlad Ralovich on 21.07.22.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {
    
    var googleMapView = GMSMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initialLocation = CLLocation(latitude: 53.9, longitude: 27.5667)
        googleMapView = .map(withFrame: view.frame, camera: GMSCameraPosition(target: initialLocation.coordinate, zoom: 14))
        googleMapView.delegate = self
        googleMapView.isMyLocationEnabled = true
        view.addSubview(googleMapView)
    }
}

extension ViewController: GMSMapViewDelegate {
    
}
