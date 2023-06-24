//
//  DetailVC.swift
//  FoursquareClone
//
//  Created by mac on 6/22/23.
//

import UIKit
import MapKit
import Parse

class DetailVC: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeTypeLabel: UILabel!
    @IBOutlet weak var placeAtmosphereLabel: UILabel!
    @IBOutlet weak var detailMapView: MKMapView!
    var chosenPlaceId = ""
    var chosenLatitude = Double()
    var chosenLongtitude = Double()

    override func viewDidLoad() {
        super.viewDidLoad()
        getDatafromParse()
        detailMapView.delegate = self
    }

    func getDatafromParse() {
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: chosenPlaceId)
        query.findObjectsInBackground { objects, error in
            if error != nil {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
            } else {
                if objects != nil && objects!.count > 0 {
                    let object = objects![0]
                    if let placeName = object.object(forKey: "name") as? String {
                        self.placeNameLabel.text = placeName
                    }
                    if let placeType = object.object(forKey: "type") as? String {
                        self.placeTypeLabel.text = placeType
                    }
                    if let placeAtmosphere = object.object(forKey: "atmosphere") as? String {
                        self.placeAtmosphereLabel.text = placeAtmosphere
                    }
                    if let placeLatitude = object.object(forKey: "latitude") as? String {
                        self.chosenLatitude = Double(placeLatitude)!
                    }
                    if let placeLongtitude = object.object(forKey: "longtitude") as? String {
                        self.chosenLongtitude = Double(placeLongtitude)!
                    }
                    if let imageData = object.object(forKey: "image") as? PFFileObject {
                        imageData.getDataInBackground { data, error in
                            if error != nil {
                                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                            } else if data != nil {
                                self.detailImageView.image = UIImage(data: data!)
                            }
                        }
                    }
                    let location = CLLocationCoordinate2D(latitude: self.chosenLatitude, longitude: self.chosenLongtitude)
                    let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
                    let region = MKCoordinateRegion(center: location, span: span)
                    let annotation = MKPointAnnotation()
                    annotation.coordinate.latitude = self.chosenLatitude
                    annotation.coordinate.longitude = self.chosenLongtitude
                    annotation.title = self.placeNameLabel.text!
                    annotation.subtitle = self.placeTypeLabel.text!
                    self.detailMapView.setRegion(region, animated: true)
                    self.detailMapView.addAnnotation(annotation)
                }
            }
        }
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            }
            
            let reuseId = "pin"
            
            var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
            
            if pinView == nil {
                pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                pinView?.canShowCallout = true
                let button = UIButton(type: .detailDisclosure)
                pinView?.rightCalloutAccessoryView = button
            } else {
                pinView?.annotation = annotation
            }
            
            return pinView
            
        }
        
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            if self.chosenLongtitude != 0.0 && self.chosenLatitude != 0.0 {
                let requestLocation = CLLocation(latitude: self.chosenLatitude, longitude: self.chosenLongtitude)
                
                CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
                    if let placemark = placemarks {
                        
                        if placemark.count > 0 {
                            
                            let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                            let mapItem = MKMapItem(placemark: mkPlaceMark)
                            mapItem.name = self.placeNameLabel.text
                            
                            let launchOptions = [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving]
                            
                            mapItem.openInMaps(launchOptions: launchOptions)
                        }
                        
                    }
                }
                
            }
        }

}
