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
import Realm

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBAction func unwindToVC(segue:UIStoryboardSegue) {
    }
    @IBOutlet weak var tableView: UITableView!

    var currentNote: Note?
    
    var originMarker: GMSMarker!
    
    var destinationMarker: GMSMarker!
    
    var routePolyline: GMSPolyline!

    var notes: Results<Note>! {
        didSet {
            // Whenever notes update, update the table view
            tableView?.reloadData()
        }
    }
    var note:Note?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        note = Note()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let realm = Realm()
        notes = realm.objects(Note)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AddNewNote" {
            let mapViewController = segue.destinationViewController as! MapViewController
            mapViewController.note = Note()

        }
//        else {
//            let mapViewController = segue.destinationViewController as! MapViewController
//            //WorldMapViewController.note = Note()
//        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPathindexPath: NSIndexPath) -> Bool {
        return true
    }
    

    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            var deletedcell = tableView.cellForRowAtIndexPath(indexPath)
            let note = notes[indexPath.item] as Note
            let realm = Realm()
            println(indexPath.item)
            realm.write() {
                println(realm.objects(Note))
                realm.delete(note)
                println(realm.objects(Note))
                self.notes = realm.objects(Note)
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        

        saveNote()
    }
    
    func saveNote() {
        let myNote = Note()
        myNote.title   = " "
        let realm = Realm() // 1
        realm.write() { // 2
            realm.add(myNote) // 3
        }
//    currentNote = Note()
//    note = currentNote
//        if let note = notes {
//            let realm = Realm()
//            var index = notes
//            var changingNote:Note = Note()
//                changingNote.title = notes[index].title
//                realm.write{
//                    realm.add(note)
//                    self.notes = realm.objects(Note)
//                }
//            }
//            tableView.reloadData()
//    }
    }
}
extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NoteCell", forIndexPath: indexPath) as! TableViewCell
        
        let row = indexPath.row
        let note = notes[row] as Note
        cell.note = note
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(notes?.count ?? 0)
    }
}


