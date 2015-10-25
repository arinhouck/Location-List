//
//  DetailController.swift
//  Table View
//
//  Created by Arin Houck on 9/18/15.
//  Copyright © 2015 Arin Houck. All rights reserved.
//

import UIKit
import MapKit

class DetailController: UIViewController, EditControllerDelegate {
    
    @IBOutlet weak var detailDescription: UILabel!
    
    @IBOutlet weak var latitude: UILabel!
    @IBOutlet weak var longitude: UILabel!

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var segmentedMapType: UISegmentedControl!
    @IBOutlet weak var map: MKMapView!
    
    
    @IBOutlet var nav: UINavigationItem!
    
    var location:Location? = nil
    
    func editControllerResponse(parameter: AnyObject)
    {
        location = parameter as? Location
        self.setLocation()
    }
    
    func setLocation() {
        let name = self.location!.name
        let desc = self.location!.desc
        let imageName = self.location!.imageName
        nav.title = name
        detailDescription.text = desc
        markAddress(name!)
        
        image.image = UIImage(named: imageName!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if location != nil {
            self.setLocation()
        }
        
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
                self.latitude.text = ani.coordinate.latitude.description
                self.longitude.text = ani.coordinate.longitude.description
                ani.title = self.location?.name!
                
                self.map.addAnnotation(ani)
            }
        }

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "edit"
        {
            let goNext = segue.destinationViewController as! EditController
            goNext.delegate = self
            goNext.location = location
        }
        
    }
    
    
}
