//
//  Downloader.swift
//  RPAC
//
//  Created by Ty Schultz on 6/25/16.
//  Copyright © 2016 Ty Schultz. All rights reserved.
//

import UIKit
import Kanna

struct Event {
    var time: String
    var location: String
    var activity: String
    var building: String

}

class Downloader: NSObject {
    var events : [[Event]]!
    var buildings : [String]!
    
    func downloadSchedule() -> ([[Event]]!,[String]!, Int) {
        events = []
        buildings = []
        var status = 0
        // Set the page URL we want to download
        let URL = NSURL(string: "https://recsports.osu.edu/schedule/")
        
        // Try downloading it
        
        do {
            
            let htmlSource = try String(contentsOfURL: URL!, encoding: NSUTF8StringEncoding)
            
            if let doc = Kanna.HTML(html: htmlSource, encoding: NSUTF8StringEncoding) {
                
                var count = 0
                var currentBuilding = ""
                let content = doc.css("table , h3")
                for row in content {
                    //Title of building
                    if count % 2 == 0 {
                        buildings.append(row.text!)
                        currentBuilding = row.text!
                    }
                        //Details for building
                    else{
                        let event = row.xpath("tr")
                        var currentEvents : [Event] = []
                        
                        for singleEvent in event{
                            //put each row into an array
                            let tableRows = singleEvent.xpath("td")
                            
                            var index = 0
                            var time = ""
                            var activity = ""
                            var location = ""
                            for detail in tableRows {
                                
                                switch index {
                                case 0:
                                    time = detail.text!
                                case 1:
                                    activity = detail.text!
                                case 2:
                                    location = detail.text!
                                    currentEvents.append(Event(time: time, location: location, activity: activity, building: currentBuilding ))
                                    index = 0
                                default:
                                    index = 0
                                }
                                index += 1
                            }
                            
                        }
                        events.append(currentEvents)
                    }
                    count += 1
                }
            }
        }catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
            status = error.code
        }
        
//        for activity in events {
//            print("building: " + activity.0)
//            let allEvents = activity.1
//            for event in allEvents {
//                print("TIME: \(event.time), LOCATION: \(event.location), ACTIVITY: \(event.activity)")
//            }
//        }
        
        return (events, buildings,status)
    }
    
    func findBasketballEvents(eventList : [[Event]]) -> [Event] {
    
        var basketballEvents :[Event] = []
        
        for building in eventList {
            for singleEvent in building {
                if singleEvent.activity.containsString("Basketball"){
                    basketballEvents.append(singleEvent)
                }
            }
        }
        
        return basketballEvents
    }
}
