//
//  ViewController.swift
//  tableViewPractice
//
//  Created by Mlumovic on 1/13/16.
//  Copyright © 2016 Mlumovic. All rights reserved.
//

import UIKit
//bring in data scorce and delegate protocols for table views
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBOutlet weak var myTableView: UITableView!
    var superheroes = ["Batman", "Ironman", "Superman", "Spiderman", "Hulk", "Flash"]
    var realNames = ["Bruce Wayne", "Tony Stark", "Clark Kent", "Peter Parker", "Bruce Baner", "Barry Allen"]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //set table view, deatasorce and delegate to view controler
        myTableView.dataSource = self
        myTableView.delegate = self
        editButton.tag = 0
        
    }
    @IBAction func editButtonTapped(sender: AnyObject)
    {
        if editButton.tag == 0
        {
            myTableView.editing = true
            editButton.tag = 1
        }
        else
        {
            myTableView.editing = false
            editButton.tag = 0 
        }
    }
    @IBAction func addButtonTapped(sender: AnyObject)
    {
        let myAlert = UIAlertController(title: "Add Super Hero", message: nil, preferredStyle: .Alert)
        myAlert.addTextFieldWithConfigurationHandler { (nameTextField) -> Void in
            nameTextField.placeholder = "Add Super Hero Name"
        }
        
        myAlert.addTextFieldWithConfigurationHandler { (nameAilasField) -> Void in
            nameAilasField.placeholder = "Add Ailas Hero Name"
        }
        var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        myAlert.addAction(cancelAction)
        
        var addAction = UIAlertAction(title: "Add", style: .Default) { (addAction) -> Void in
            let superHeroTf = myAlert.textFields![0] as UITextField
            let ailasTF = myAlert.textFields![1] as UITextField
            self.superheroes.append(superHeroTf.text!)
            self.realNames.append(ailasTF.text!)
            self.myTableView.reloadData()
        }
        myAlert.addAction(addAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
    //requierd funtion for table views protocols- sends data to cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        //creat a cell variable for table view 
        let myCell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)
        // sets properties of cell text
        myCell.textLabel?.text = superheroes[indexPath.row]
        myCell.detailTextLabel?.text = realNames[indexPath.row]
        return myCell
    }
    
    //requierd funtion for table views protocols- sets number of rows in tabels
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return superheroes.count
    }
    // delete 
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete
        {
            superheroes.removeAtIndex(indexPath.row)
            realNames.removeAtIndex(indexPath.row)
        //reloads table view data
            myTableView.reloadData()
        }
    }
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath)
    {
        let superHero = superheroes[sourceIndexPath.row]
        superheroes.removeAtIndex(sourceIndexPath.row)
        superheroes.insert(superHero, atIndex: destinationIndexPath.row)
        
        let ailias = realNames[sourceIndexPath.row]
        realNames.removeAtIndex(sourceIndexPath.row)
        realNames.insert(ailias, atIndex: destinationIndexPath.row)
    }
    
    

}

