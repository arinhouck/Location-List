//
//  ViewController.swift
//  Table View
//
//  Created by Arin Houck on 9/18/15.
//  Copyright © 2015 Arin Houck. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var locationTable: UITableView!
    
    var context: NSManagedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var dataViewController: NSFetchedResultsController = NSFetchedResultsController()

    
    func getFetchResultsController() -> NSFetchedResultsController {
        
        dataViewController = NSFetchedResultsController(fetchRequest: listFetchRequest(), managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        return dataViewController
        
    }
    
    func listFetchRequest() -> NSFetchRequest {
        
        let fetchRequest = NSFetchRequest(entityName: "Location")
        let sortDescripter = NSSortDescriptor(key: "name", ascending: true)
        fetchRequest.sortDescriptors = [sortDescripter]
        return fetchRequest
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataViewController = getFetchResultsController()
        
        dataViewController.delegate = self
        
        do {
            try dataViewController.performFetch()
        } catch _ {
        }
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.locationTable.reloadData()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let numberOfSections  = dataViewController.sections?.count
        return numberOfSections!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = dataViewController.sections?[section].numberOfObjects
        return numberOfRowsInSection!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.locationTable.dequeueReusableCellWithIdentifier("locationCell", forIndexPath: indexPath) as UITableViewCell
        let location = dataViewController.objectAtIndexPath(indexPath) as! Location
        cell.textLabel?.text = "\(location.name!)"
        cell.detailTextLabel?.text = "\(location.desc!)"
        
        
        return cell
        
    }
    
    
    func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView!, commitEditingStyle editingStyle:   UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            let record = dataViewController.objectAtIndexPath(indexPath) as! Location
            context.deleteObject(record)
            do {
                try context.save()
            } catch {}
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "detail"
        {
            let cell = sender as! UITableViewCell
            let indexPath = self.locationTable.indexPathForCell(cell)
            let dest: DetailController =  segue.destinationViewController as! DetailController
            let row = dataViewController.objectAtIndexPath(indexPath!) as! Location
            dest.location = row
        }
        
    }
    
    
    
    
    
//    // This is a data source method that will be called when table is loaded
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.rows.count
//    }
//    // This datasource method will create each cell of the table
//    func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCellWithIdentifier("locationCell", forIndexPath: indexPath)
//        
//        cell.textLabel?.text = data.rows[indexPath.row].getName();
//        let cell_Image = UIImage(named: data.rows[indexPath.row].getImageName() + ".png")
//        cell.imageView?.image = cell_Image
//        
//        return cell;
//    }
//    
//    
//    
//    // segue will be called as a row of the table is selected
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        let selectedIndex: NSIndexPath = self.locationTable.indexPathForCell(sender as! UITableViewCell)!
//        
//        self.imageName = data.rows[selectedIndex.row].getImageName()
//        self.locationName = data.rows[selectedIndex.row].getName()
//        self.locationDesc = data.rows[selectedIndex.row].getDescription()
//        
//        if(segue.identifier == "detail"){
//            if let detailViewController: DetailController = segue.destinationViewController as? DetailController {
//                detailViewController.imageName = imageName
//                detailViewController.locationName = locationName
//                detailViewController.locationDesc = locationDesc
//            }
//        }
//    }


}

