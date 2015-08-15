import UIKit
import GoogleMaps
import RealmSwift
import MapKit


class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: GMSMapView!
    var camera: GMSCameraPosition!
    var newLocation = CLLocationManager()

    let locationManager = CLLocationManager()

    var notes: Note!
    
    var endLocation: CLLocationCoordinate2D?
    
    var photoTakingHelper: PhotoTakingHelper?
    
    var endMarker = GMSMarker()
    
    var didSelectPhoto = false
    
    var selectedPhoto: UIImage!
    
    var viewDisappeared = false
    
    var note: Note?
    
    var newNote = true
    
    var locationMarker: GMSMarker!

    var sender = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        note = Note()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if let note = note {
                if note.setImage  {
                    photoTakingHelper = PhotoTakingHelper(viewController: self, callback: { (image: UIImage?) in
                    self.selectedPhoto = image!
                    })
                    note.setImage = true
                }
        }
    }

    override func viewWillDisappear(animated: Bool) {
        if viewDisappeared {
            saveNote()
        } else {
            viewDisappeared = true
        }
        saveNote()
    }
 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        segue.destinationViewController.note
        if selectedPhoto != nil && didSelectPhoto{
            newNote = false
            note!.setImage = false
        }
    }
    
    func saveNote() {
        if let note = note {
            
            note.latitude = (self.locationManager.location.coordinate.latitude.description as NSString).doubleValue
            note.longitude = (self.locationManager.location.coordinate.longitude.description as NSString).doubleValue
            note.modificationDate = NSDate()
            note.setImage = true
            
            let realm = Realm()
            
            realm.write {
                //note.imageData = UIImageJPEGRepresentation(self.selectedPhoto, 0.8)
                realm.add(note)
            }

            println(note.latitude)
            println(note.longitude)
            println(note.modificationDate)
            println(note.setImage)
        }

    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {

        if let location = locationManager.location {
            self.endLocation = location.coordinate
            mapView.camera = GMSCameraPosition.cameraWithLatitude(locationManager.location.coordinate.latitude, longitude: locationManager.location.coordinate.longitude, zoom: 16)
        } else {
            self.camera = GMSCameraPosition.cameraWithLatitude(37.33233, longitude: -122.03121, zoom: 16)
        }
        
        saveNote()
        mapView.settings.myLocationButton = true
        mapView.myLocationEnabled = true
        route()
    }
    

    func route(){
        
        var marker = GMSMarker()
        
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.map = self.mapView
        
        var shouldUseGoogleMaps = (UIApplication.sharedApplication().canOpenURL(NSURL(string: "comgooglemaps://")!))
        if shouldUseGoogleMaps == true{
            let url = NSURL(string: "comgooglemaps://?saddr=Current+Location&daddr=\(note!.latitude),\(note!.longitude)")
            UIApplication.sharedApplication().openURL(url!)
            
        }
        else{
            println("\(note!.latitude),\(note!.longitude)")
            let url = NSURL(string: "http://maps.apple.com/maps?saddr=Current%20Location&daddr=\(note!.latitude),\(note!.longitude)")
            UIApplication.sharedApplication().openURL(url!)
        }
    }
}