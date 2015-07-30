//
//  ViewController.swift
//  PhotoApp
//
//  Created by Kevin Fang on 7/22/15.
//  Copyright (c) 2015 Kevin Fang. All rights reserved.
//

import UIKit
import GoogleMaps


class ViewController: UIViewController{
    

    
    
    /*@IBAction func addNew(sender: AnyObject) {
    
    }*/
    @IBOutlet weak var tableView: UITableView!
    @IBAction func CameraViewController
        (segue: UIStoryboardSegue) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableCell", forIndexPath: indexPath) as! TableViewCell//1
        
        let row = indexPath.row
        cell.textLabel?.text = ""
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
}