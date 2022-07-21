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
    var currentPositionButton: UIButton!
    
    var artworks: [ArtworkModel] = [] {
        didSet {
            for artwork in artworks where artwork.lang_id == 1 {
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(artwork.point.lat), longitude: CLLocationDegrees(artwork.point.lng))
                marker.title = .init(htmlEncodedString: artwork.point_name)
                marker.map = self.googleMapView
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let initialLocation = CLLocation(latitude: 53.9, longitude: 27.5667)
        googleMapView = .map(withFrame: view.frame, camera: GMSCameraPosition(target: initialLocation.coordinate, zoom: 6))
        googleMapView.isMyLocationEnabled = true
        view.addSubview(googleMapView)
        configureButton()
        loadArtwork()
    }
    
    private func loadArtwork() {
        let request = AF.request("https://fish-pits.krokam.by/api/rest/points/")
        request.responseDecodable(of: [ArtworkModel].self) { [weak self] response in
            guard let artworks = response.value else {
                self?.showAlert()
                return
            }
            self?.artworks = artworks
        }
    }
    
    private func configureButton() {
        currentPositionButton = UIButton(frame: CGRect(x: view.bounds.maxX - 56, y: view.bounds.maxY - 56, width: 40, height: 40))
        currentPositionButton.addTarget(self, action: #selector(camera), for: .touchUpInside)
        currentPositionButton.setImage(UIImage(named: "position"), for: .normal)
        view.addSubview(currentPositionButton)
    }
    @objc private func camera() {
        guard let location = googleMapView.myLocation else { return }
        googleMapView.animate(toLocation: location.coordinate)
        googleMapView.animate(toZoom: 16)
    }
    private func showAlert() {
        let alert = UIAlertController(title: "Здарылася памылка", message: "Праверце подключэнне да інернета", preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Адмена", style: .destructive)
        let reloadAction = UIAlertAction(title: "Абнавіць", style: .default) { [weak self] _ in
            self?.loadArtwork()
        }
        alert.addAction(actionCancel)
        alert.addAction(reloadAction)
        show(alert, sender: nil)
    }
}
