//
//  WorldMapViewController.swift
//  PhotoApp
//
//  Created by Kevin Fang on 8/14/15.
//  Copyright (c) 2015 Kevin Fang. All rights reserved.
//

import UIKit
import GoogleMaps

class WorldMapViewController: UIViewController {

    var note: Note?
    
    @IBOutlet weak var worldMap: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        worldMap.camera = GMSCameraPosition.cameraWithLatitude(37.3323,longitude: 120.123, zoom:1)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func markers(){
        var marker = GMSMarker()
        marker.appearAnimation = kGMSMarkerAnimationPop
        marker.map = self.worldMap
        
        var shouldUseGoogleMaps = (UIApplication.sharedApplication().canOpenURL(NSURL(string: "comgooglemaps://")!))
        if shouldUseGoogleMaps == true{
            let url = NSURL(string: "comgooglemaps://?saddr=Current+Location&daddr=\(note!.latitude),\(note!.longitude)")
            UIApplication.sharedApplication().openURL(url!)
            
        }
        else{
            let url = NSURL(string: "http://maps.apple.com/maps?saddr=Current%20Location&daddr=\(note!.latitude),\(note!.longitude)")
            UIApplication.sharedApplication().openURL(url!)
        }
    }

}
