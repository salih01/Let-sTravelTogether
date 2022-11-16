//
//  MapViewController.swift
//  LetsTravelTogether
//
//  Created by ALFA on 16.11.2022.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

extension MapViewController: MKMapViewDelegate,CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //Koordinant ,lokasyon
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        
        chooseLatitude = location.latitude
        chooseLongitude = location.longitude
        
        //Zoom seviyesi
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        mapView.delegate = self

        
    }
    
    
    
}



class MapViewController: UIViewController {
    
    // MARK: - UI Elements
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var textFieldNot: UITextField!
    @IBOutlet weak var textFieldKimle: UITextField!
    
    var chooseLongitude:Double?
    var chooseLatitude:Double?
    
    // MARK: - Properties
    
    var locationManager = CLLocationManager() //lokasyon managerı
    
    
    
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gesture()
        locationManagers()
        
        
        
    }
    
    // MARK: - Functions
    
    
    func locationManagers()  {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }
    
    func gesture() {
        
        let gestureRecognizer = UILongPressGestureRecognizer(target:self, action:#selector(LongPressChoose(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 2
        
        mapView.addGestureRecognizer(gestureRecognizer)
        
        
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(tikla))
        view.addGestureRecognizer(gestureRecognizer2)
        
    }
    
    @objc func tikla(){
        view.endEditing(true)
    }
    
    @objc func LongPressChoose(gestureRecognizer:UILongPressGestureRecognizer){
        
        if gestureRecognizer.state == .began {
            let toucedPoint = gestureRecognizer.location(in: self.mapView)
            let touchedCoordinates = self.mapView.convert(toucedPoint, toCoordinateFrom: self.mapView)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = touchedCoordinates
            annotation.title = textFieldNot.text
            annotation.subtitle = textFieldKimle.text
            self.mapView.addAnnotation(annotation)
            
        }
        
    }
    
    // MARK: - Actions
    
    
    
    
    @IBAction func saveButton(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        
        newPlace.setValue(textFieldNot.text, forKey: "title")
        newPlace.setValue(textFieldKimle.text, forKey: "subTitle")
        newPlace.setValue(chooseLatitude, forKey: "latitude")
        newPlace.setValue(chooseLongitude, forKey: "longitude")
        newPlace.setValue(UUID(), forKey: "id")
        
        
        do {
            try context.save()
            print("success")
        } catch{
            
            let nserror = error as NSError
            fatalError("Hata geldi \(nserror), \(nserror.userInfo)")
            
        }
        
    }
    
    
    
}
