//
//  SpeakersViewController.swift
//  Big Data LA
//
//  Created by Manish Dwibedy on 6/10/16.
//  Copyright © 2016 Manish Dwibedy. All rights reserved.
//

import UIKit

class SpeakersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // The speaker's list
    var speakers = SpeakerData.getSpeakerInfo()
    
    var currentSpeaker: [String:String] = [:]
    var showDetails = false
    
    @IBOutlet weak var speakerTable: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        self.speakers = API.speakers
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Adding deletgate to the controller
        speakerTable.delegate = self
        speakerTable.dataSource = self
        
        //let speakers = API.speakers
        //print(speakers[0]["name"]!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // Number of sections
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of rows
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speakers.count
    }
    
    // Rendering individual cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->   UITableViewCell{
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        let row = indexPath.row
        cell.textLabel?.text = speakers[row]["name"]
        cell.detailTextLabel?.text = speakers[row]["title"]
        return cell
    }
    
    // Selecting individual cell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        speakerTable.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        let speaker = speakers[row]
        
        print("Selected the speaker :" + speaker["name"]!)
        
        self.currentSpeaker = speaker
        self.performSegueWithIdentifier("showSpeakerDetails", sender: self)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "showSpeakerDetails") {
            let svc = segue.destinationViewController as! UITabBarController;
            let detailViewController = svc.viewControllers![0] as! SpeakerDetailViewController
            detailViewController.speaker = self.currentSpeaker
            
            let talkViewController = svc.viewControllers![1] as! SpeakerTalksViewController
            talkViewController.speaker = self.currentSpeaker
            
            API.getTalkDetails(self.currentSpeaker["id"]!)
            
        }
    }

}