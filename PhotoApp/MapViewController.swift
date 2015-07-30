import UIKit
import GoogleMaps

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    let locationManager = CLLocationManager()
    var camera: GMSCameraPosition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        if let location = locationManager.location {
            self.camera = GMSCameraPosition.cameraWithLatitude(locationManager.location.coordinate.latitude, longitude: locationManager.location.coordinate.longitude, zoom: 16)
        } else {
            self.camera = GMSCameraPosition.cameraWithLatitude(37.33233, longitude: -122.03121, zoom: 16)
        }
        
        
        self.mapView.camera = self.camera
        mapView.myLocationEnabled = true
        mapView.settings.myLocationButton = true
        

        
    }
    
}