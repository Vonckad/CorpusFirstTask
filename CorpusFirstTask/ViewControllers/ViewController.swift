//
//  ViewController.swift
//  CorpusFirstTask
//
//  Created by Vlad Ralovich on 21.07.22.
//

import UIKit
import GoogleMaps
import Alamofire

class ViewController: UIViewController {
    
    var googleMapView = GMSMapView()
    var artworks: [ArtworkModel] = [] {
        didSet {
            for artwork in artworks {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(artwork.point.lat), longitude: CLLocationDegrees(artwork.point.lng))
                marker.title = String.init(htmlEncodedString: artwork.point_name)
                marker.map = self.googleMapView
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initialLocation = CLLocation(latitude: 53.9, longitude: 27.5667)
        googleMapView = .map(withFrame: view.frame, camera: GMSCameraPosition(target: initialLocation.coordinate, zoom: 6))
//        googleMapView.isMyLocationEnabled = true
        view.addSubview(googleMapView)
        loadArtwork()
        
    }
    
    private func loadArtwork() {
        let request = AF.request("https://fish-pits.krokam.by/api/rest/points/")
        request.responseDecodable(of: [ArtworkModel].self) { response in
            guard let artworks = response.value else { return }
            self.artworks = artworks
        }
    }
}
