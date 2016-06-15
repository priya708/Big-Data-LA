//
//  API.swift
//  Big Data LA
//
//  Created by Manish Dwibedy on 6/11/16.
//  Copyright © 2016 Manish Dwibedy. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class API{
    static var speakers = [[String:String]]()
    static var talk = [String: String]()
    static func getSpeaker(){
        let URL = API_CONSTANTS.getSpeakerURL()
        
        
        Alamofire.request(.GET, URL).responseJSON {
            response in
                if let speakersJSON = response.result.value {
                    let speakersArray = JSON(speakersJSON)
                    
                    
                    for (_, object) in speakersArray {
                        let speaker: [String:String] = [
                            "id": object["_id"]["$oid"].stringValue,
                            "name" : object["name"].stringValue,
                            "title" : object["title"].stringValue,
                            "about" : object["about"].stringValue
                        ]
                        API.speakers.append(speaker)
                    }
                }
        }
    }
    
    static func getTalkDetails(speakerID: String){
        let URL = API_CONSTANTS.getTalkURL(speakerID)
        var talk = [String:String]()
        print("Calling API Now for " + speakerID)
        Alamofire.request(.GET, URL)
            .responseJSON { response in
                if let talkJSON = response.result.value {
                    API.talk = [String:String]()
                    let talkArray = JSON(talkJSON)["talk"]
                    
                    for (key, value) in talkArray {
                        talk[key] = value.stringValue
//                        talk["name"] = object["name"].stringValue
//                        talk["location"] = object["location"].stringValue
//                        talk["time"] = object["time"].stringValue
//                        talk["about"] = object["about"].stringValue
                    }
                    API.talk = talk
                }
        }
    }
}