//
//  ViewController.swift
//  PhotoApp
//
//  Created by Kevin Fang on 7/22/15.
//  Copyright (c) 2015 Kevin Fang. All rights reserved.
//

import UIKit
import GoogleMaps
import RealmSwift

class ViewController: UIViewController{
    @IBAction func unwindToVC(segue:UIStoryboardSegue) {
    }
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var Add: UIBarButtonItem!

    var notes: Results<Note>! {
        didSet {
            // Whenever notes update, update the table view
            tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        let myNote = Note()
        myNote.title   = "Super Simple Test Note"
        myNote.content = "A long piece of content"
        let realm = Realm()
        realm.write() {
            realm.add(myNote)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.placeholder = nil
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        textField.placeholder = "Title"
    }
}


extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell", forIndexPath: indexPath) as! TableViewCell
        
        let row = indexPath.row
        cell.textLabel?.text = ""
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
}