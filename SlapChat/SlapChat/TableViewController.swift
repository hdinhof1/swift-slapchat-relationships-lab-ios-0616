//
//  TableViewController.swift
//  SlapChat
//
//  Created by Flatiron School on 7/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController { //Recipient should come second in the viewcontroller nav order but I like to go from users first like iMessage

    
    //var managedMessageObjects: [Message]? = []
    let store: DataStore = DataStore()
    
    var recipient : Recipient!
    var recipients = [Recipient]()
    
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchData()
        store.saveContext()
        
        recipients = store.fetchDataByEntity(Recipient.entityName, key: nil) as! [Recipient]
        
        messages = store.fetchDataByEntity(Message.entityName, key: nil) as! [Message]
        
        print(recipients)
        print(messages)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(true)
        store.fetchData()
        tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return store.messages.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath)
        
        let eachRecipient = store.recipients[indexPath.row]
        cell.textLabel?.text = eachRecipient.name
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let messagesDestinationVC = segue.destinationViewController as! MessagesTableViewController
        
        
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let selectedRecipient = self.recipients[indexPath.row]
            let messagesSet = selectedRecipient.messages
            //print ("Messages are \(messagesSet)")
            if let messagesSet = messagesSet {
                messagesDestinationVC.messages = messagesSet
            }
        }
        
        
    }
}