//
//  MainTableViewController.swift
//  FreeFinder
//
//  Created by Sean on 10/31/16.
//  Copyright © 2016 Sean Wang. All rights reserved.
//

import UIKit
import SwiftyJSON
import JSONJoy

class MainTableViewController: UITableViewController {
    
    var events: [Event] = [Event]()
    var weeks: [Week] = [Week]()

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl?.addTarget(self, action: #selector(MainTableViewController.handleRefresh(refreshControl:)), for: .valueChanged)
        self.refreshControl?.attributedTitle = NSAttributedString(string: "Test string!")
        
        
        
        RestApiManager.shared.getEvents(completion: { data in
            for index in 0...data["events"].count - 1 {
                let eventData = data["events"][index]
                do {
                    let event = try Event(JSONDecoder(eventData.rawString()!))
                    self.events.append(event)
                } catch {
                    print("ERROR: Unable to parse JSON")
                }
            }
            self.weeks = WeekParserService.shared.getEventsByWeeks(events: self.events)
            self.tableView.reloadData()
//            print(self.events)
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
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        refreshControl.endRefreshing()
        
        print("REfereshing")
        self.tableView.reloadData()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return weeks.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return weeks[section].displayName
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weeks[section].events.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        
        cell.eventNameLabel.text = weeks[indexPath.section].events[indexPath.item].eventTitlePrint
        cell.eventSecondaryLabel.text = weeks[indexPath.section].events[indexPath.item].startTimePrint
        cell.eventLocationLabel.text = weeks[indexPath.section].events[indexPath.item].location
        
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
        
        let indexPath = self.tableView.indexPath(for: sender as! UITableViewCell)!
        (segue.destination as! EventDetailsViewController).event = weeks[indexPath.section].events[indexPath.item]
        
    }

}
