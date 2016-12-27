//
//  MainTableViewController.swift
//  FreeFinder
//
//  Created by Sean on 10/31/16.
//  Copyright © 2016 Sean Wang. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainTableViewController: UITableViewController {
    
    var data: JSON = JSON("{events: []}")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        RestApiManager.shared.getEvents(completion: { data in
            print(self.data = data)
            self.tableView.reloadData()
            print(self.data)
        })
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data["events"].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        
        // Move string conversion to data first load, for efficiency.
        let startTimeString: String = data["events"][indexPath.item]["startTime"].string!
        let eventTitle: String = data["events"][indexPath.item]["eventTitle"].string!
        cell.eventNameLabel.text = (eventTitle.characters.count > 25) ? eventTitle.substring(to: eventTitle.index(eventTitle.startIndex, offsetBy: 25)) + "..." : eventTitle
        
        print(cell.detailTextLabel?.text)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let startTime: Date = formatter.date(from: startTimeString)!
        
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        print(formatter.string(from: startTime))
        cell.eventSecondaryLabel.text = formatter.string(from: startTime)
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        (segue.destination as! EventDetailsViewController).eventData = data["events"][(self.tableView.indexPath(for: sender as! UITableViewCell)?.item)!]
        
    }

}
