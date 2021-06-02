//
//  LocationVC.swift
//  FinalProject
//
//  Created by Zhaisan on 13.05.2021.
//

//import UIKit
//import MapKit
//
//
//protocol Locate{
//    func Location(_ name: String, _ surname: String)
//}
//
//class LocationVC: UIViewController, UISearchResultsUpdating {
//    
//    let mapView = MKMapView()
//    var delegate: Locate?
//    let searchVC = UISearchController(searchResultsController: ResultsVC())
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //title = "Maps"
//        view.addSubview(mapView)
//        searchVC.searchBar.backgroundColor = .secondarySystemBackground
//        searchVC.searchResultsUpdater = self
//        navigationItem.searchController = searchVC
//       
//        
//    }
//   
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        mapView.frame = CGRect(x: 0, y: view.safeAreaInsets.top,
//                               width: view.frame.size.width,
//                               height: view.frame.size.height - view.safeAreaInsets.top)
//    }
//    
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let query = searchController.searchBar.text,
//              !query.trimmingCharacters(in: .whitespaces).isEmpty,
//              let resultsVC = searchController.searchResultsController as? ResultsVC else{
//            return
//        }
//        
//        resultsVC.delegate = self
//        
//        GooglePlacesManager.shared.findPlaces(query: query) { result in
//            switch result {
//            case .success(let places):
//                
//                DispatchQueue.main.async {
//                    resultsVC.update(with: places)
//                }
//                
//            case .failure(let error):
//                print(error)
//            }
//            
//        }
//    }
//}
//
//extension LocationVC: ResultsVCDelegate{
//    func didTapPlace(with coordinates: CLLocationCoordinate2D) {
//        searchVC.searchBar.resignFirstResponder()
//        searchVC.dismiss(animated: true, completion: nil)
//        
//        // Remove all map pins
//        let annotations = mapView.annotations
//        mapView.removeAnnotations(annotations)
//        
//        // Add a map pin
//        let pin = MKPointAnnotation()
//        pin.coordinate = coordinates
//        mapView.addAnnotation(pin)
//        mapView.setRegion(
//            MKCoordinateRegion(center: coordinates,
//                               span: MKCoordinateSpan(latitudeDelta: 0.2,
//                                                      longitudeDelta: 0.2)),
//                                                      animated: true)
//        
//        
//    }
//}
