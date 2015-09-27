//
//  ViewController.swift
//  Table View
//
//  Created by Arin Houck on 9/18/15.
//  Copyright © 2015 Arin Houck. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var locationTable: UITableView!
    var data: TableData = TableData()
    
    var locationName: String = ""
    var locationDesc: String = ""
    var imageName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // This is a data source method that will be called when table is loaded
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.rows.count
    }
    // This datasource method will create each cell of the table
    func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("locationCell", forIndexPath: indexPath)
        
        cell.textLabel?.text = data.rows[indexPath.row].getName();
        let cell_Image = UIImage(named: data.rows[indexPath.row].getImageName() + ".png")
        cell.imageView?.image = cell_Image
        
        return cell;
    }
    
    
    
    // segue will be called as a row of the table is selected
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let selectedIndex: NSIndexPath = self.locationTable.indexPathForCell(sender as! UITableViewCell)!
        
        self.imageName = data.rows[selectedIndex.row].getImageName()
        self.locationName = data.rows[selectedIndex.row].getName()
        self.locationDesc = data.rows[selectedIndex.row].getDescription()
        
        if(segue.identifier == "detail"){
            if let detailViewController: DetailController = segue.destinationViewController as? DetailController {
                detailViewController.imageName = imageName
                detailViewController.locationName = locationName
                detailViewController.locationDesc = locationDesc
            }
        }
    }


}

