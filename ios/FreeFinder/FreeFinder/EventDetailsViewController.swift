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
    
    var eventData: JSON = JSON("")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = eventData["eventTitle"].string!
        // Do any additional setup after loading the view.
        print(eventData)
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
