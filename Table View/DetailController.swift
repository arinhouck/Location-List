//
//  DetailController.swift
//  Table View
//
//  Created by Arin Houck on 9/18/15.
//  Copyright © 2015 Arin Houck. All rights reserved.
//

import UIKit

class DetailController: UIViewController {
    var imageName = String()
    var locationName = String()
    var locationDesc = String()
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var detailDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: "map-" + self.imageName)
        detailTitle.text = self.locationName
        detailDescription.text = self.locationDesc
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
