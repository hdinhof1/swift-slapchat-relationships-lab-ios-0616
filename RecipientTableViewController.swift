//
//  RecipientTableViewController.swift
//  SlapChat
//
//  Created by Flatiron School on 7/18/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class RecipientTableViewController: UITableViewController {
    
    let store: DataStore = DataStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return store.recipients.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("recipientCell", forIndexPath: indexPath)
        
        let currentRecipient = store.recipients[indexPath.row]
        cell.textLabel?.text = currentRecipient.name
        
        if let messageCount = currentRecipient.messages?.count{
            cell.detailTextLabel?.text = "\(messageCount)"
            
        }
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPath = tableView.indexPathForSelectedRow
        
        let selectedRecipient = store.recipients[indexPath!.row]
        
        let destinationVC = segue.destinationViewController as! TableViewController
        
        if let messageSet = selectedRecipient.messages{
            
            destinationVC.messages = messageSet
            
        }
    }
    
    
}
