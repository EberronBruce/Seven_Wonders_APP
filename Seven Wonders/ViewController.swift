//
//  ViewController.swift
//  Seven Wonders
//
//  Created by Bruce Burgess on 7/6/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

/*
 This is the view controller for the first screen in which the app enters on. This view controller holds a custom table view with customized table view cells.
 
*/


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var wonderArray: [WonderSite] = [] //Use to store data to populate the table view

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.actOnAPINotification), name: API_NOTIFY , object: nil)
        
        loadingIndicator.hidesWhenStopped = true //Hides the indicator when it stops
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let wonderItem = wonderArray[indexPath.row]
        // Sets up the cell with each custion cell
        if let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? WonderCell {
            cell.updateCell(wonderItem.name, image: wonderItem.photo)
            return cell
        } else {
            return WonderCell()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wonderArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("DetailSegue", sender: wonderArray[indexPath.row])
    }
    
    //Mark: - Call this function when HTTP API finishes 
    func actOnAPINotification() {
        dispatch_async(dispatch_get_main_queue()) { //Get back on the main thread to avoid tableView bug
            self.wonderArray = DataService.instance.wonderSites
            self.tableView.reloadData()
            self.loadingIndicator.stopAnimating() //Stop the indicator and it hides.
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailSegue" {
           
            if let wonder = sender as? WonderSite {
                if let detailVC = segue.destinationViewController as? DetailVC {
                    detailVC.wonder = wonder

                }

            }
        }
    }



}

