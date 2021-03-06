//
//  EventDetailsViewController.swift
//  FreeFinder
//
//  Created by Sean on 12/24/16.
//  Copyright © 2016 Sean Wang. All rights reserved.
//

import UIKit
import SwiftyJSON

class EventDetailsViewController: UIViewController {
    
    var event: Event?

    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var startTimeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBAction func button(_ sender: Any) {
        UIApplication.shared.openURL(URL(string: (event?.hyperlink)!)!)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Event"
        eventTitleLabel.text = event?.eventTitle
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .long
        startTimeLabel.text = formatter.string(from: (event?.startTime)!)
        locationLabel.text = event?.location
        descriptionTextView.text = event?.description
//        UIApplication.shared.openURL(URL(string: "http://www.stackoverflow.com")!)
        // Do any additional setup after loading the view.
//        print(eventData)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
