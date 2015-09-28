//
//  DetailController.swift
//  Table View
//
//  Created by Arin Houck on 9/18/15.
//  Copyright © 2015 Arin Houck. All rights reserved.
//

import UIKit
import MapKit

class DetailController: UIViewController {
    
    var imageName = String()
    var locationName = String()
    var locationDesc = String()
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var segmentedMapType: UISegmentedControl!
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTitle.text = self.locationName
        detailDescription.text = self.locationDesc
        markAddress(self.locationName)
        
        image.image = UIImage(named: "map-" + self.imageName)
        
        // Titles for Segemented Button
        segmentedMapType.setTitle("Standard", forSegmentAtIndex: 0)
        segmentedMapType.setTitle("Satellite", forSegmentAtIndex: 1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Action to control segmentented UI
    @IBAction func mapTypeChanged(sender: UISegmentedControl) {
        switch segmentedMapType.selectedSegmentIndex {
            case 0:
                map.mapType = MKMapType.Standard
            case 1:
               map.mapType = MKMapType.Satellite
            default:
            break;
        }
    }
    
    // Sets address with geocoder and fills in lat,lon in text fields
    func markAddress(sender: AnyObject) {
        let address = ( sender as! NSString)
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address as String) { (placemarks, error) -> Void in
            if let placemark = placemarks?[0] {
                let span = MKCoordinateSpanMake(2, 2)
                let region = MKCoordinateRegion(center: placemark.location!.coordinate, span: span)
                self.map.setRegion(region, animated: true)
                let ani = MKPointAnnotation()
                ani.coordinate = placemark.location!.coordinate
                self.latitudeTextField.text = ani.coordinate.latitude.description
                self.longitudeTextField.text = ani.coordinate.longitude.description
                ani.title = self.locationName
                
                self.map.addAnnotation(ani)
            }
        }

    }
    
    
}
