//
//  DetailVC.swift
//  Seven Wonders
//
//  Created by Bruce Burgess on 7/6/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

/*
 This class is used for the second screen of the app. This holds basic information as well as a map that marks the location of the destination based on its latitude and longitude.
 */


import UIKit
import MapKit

class DetailVC: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var wonderImage: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var map: MKMapView!
    
    var wonder: WonderSite?
    
    let regionRadius: CLLocationDistance = REGION_RADIUS

    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.delegate = self
        map.scrollEnabled = false
        
        wonderImage.layer.cornerRadius = wonderImage.frame.width / 10
        wonderImage.clipsToBounds = true
        
        //Check and make sure the data was passed by the first view controller
        if (wonder != nil) {
            titleLabel.text = wonder!.name
            wonderImage.image = wonder!.photo
            yearLabel.text = wonder!.year_built
            locationLabel.text = wonder!.location
            
            let location = CLLocation(latitude: wonder!.latitude, longitude: wonder!.longitude)
            createAnnotationForLocation(location)
            centerMapOnLocation(location)
        }
    }

    //Goes back to the first view controller
    @IBAction func backButtonPressed(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Mark: - This function will center the map based on the location.
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2, regionRadius * 2)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    //Mark: - This function will create a map annotation, AKA a pin.
    func createAnnotationForLocation(location: CLLocation) {
        let site = SiteAnnotation(coordinate: location.coordinate)
        map.addAnnotation(site)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        //Use this to set up the look and feel fo the annotations
        if annotation.isKindOfClass(SiteAnnotation) {
            let annoView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "Default")
            annoView.pinTintColor = UIColor.redColor()
            annoView.animatesDrop = true
            return annoView
        }
        return nil
    }



}
