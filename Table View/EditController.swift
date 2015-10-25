//
//  EditController.swift
//  Table View
//
//  Created by Arin Houck on 10/23/15.
//  Copyright © 2015 Arin Houck. All rights reserved.
//

import UIKit
import CoreData

protocol EditControllerDelegate
{
    func editControllerResponse(parameter: AnyObject)
}

class EditController: UIViewController {
    
    var delegate: DetailController?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var imageNameField: UITextField!
    
    @IBOutlet weak var descriptionTextArea: UITextView!
    
    let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var location:Location? = nil

    @IBAction func cancel(sender: UIBarButtonItem) {
        navigationController!.popViewControllerAnimated(true)
    }
    
    
    @IBAction func save(sender: UIBarButtonItem) {
        if location == nil
        {
            let context = self.context
            let ent = NSEntityDescription.entityForName("Location", inManagedObjectContext: context)
            
            let location = Location(entity: ent!, insertIntoManagedObjectContext: context)
            location.name = nameField.text!
            location.imageName = imageNameField.text!
            location.desc = descriptionTextArea.text!
            
            do {
                try context.save()
            } catch _ {
            }
        }else
        {
            location!.name = nameField.text!
            location!.imageName = imageNameField.text!
            location!.desc = descriptionTextArea.text!
            do {
                try context.save()
            } catch _ {
            }
            self.delegate?.editControllerResponse(location!)
            //            let dest: DetailController = segue.destinationViewController as! DetailController
            //            dest.location = location
        }
        
        navigationController!.popViewControllerAnimated(true)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if location != nil {
            nameField.text = location?.name!
            imageNameField.text = location?.imageName!
            descriptionTextArea.text = location?.desc!
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
