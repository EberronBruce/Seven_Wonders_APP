//
//  DataService.swift
//  Seven Wonders
//
//  Created by Bruce Burgess on 7/6/16.
//  Copyright © 2016 Red Raven Computing Studios. All rights reserved.
//

/*
 This class is used to create the HTTP request and to parse the data from the request. It uses a singleton that will keep the reference in the memory as long as the app is running. Hence, only one API call needs to be made.
*/

import Foundation
import UIKit

class DataService {
    
    static let instance = DataService() //Creates a singleton and allows all classes to access it.
    
    private var _wonderSites: [WonderSite] = []
    
    //The getter for the retrieve the array.
    var wonderSites: [WonderSite] {
        return _wonderSites
    }
    
    //Mark: - This is the public function used to do the HTTP API Call
    func getWondersFromApi() {
        if let url = NSURL(string: URL_API) {
            let session = NSURLSession.sharedSession()
            
            session.dataTaskWithURL(url) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
                
                if let responseData = data {
                    self.retrieveJSON(responseData)
                    
                    //Need to set up notification to repopulate the table
                    self.sendNotificationOut()
                } else if (error != nil) {
                    print(error.debugDescription)
                }
            }.resume()
            
        } else {
            print("URL is not valid")
        }
    }
    
    //Mark: - This function retrieves the JSON and calls a parsing function to parse the JSON dictionary.
    private func retrieveJSON(responseData: NSData) {
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
            
            if let jsonArray = json as? NSArray {
                for dict in jsonArray {
                    parseJsonDictionary(dict)
                }
            } else {
                print("JSONT CANNOT BE PUT IN NSARRAY")
            }
        } catch {
            print("Cannot get JSON")
        }
        
    }
    
    //Mark: - This function parses the JSON dictionary and stores the information in an array for later uses
    private func parseJsonDictionary(jsonDict: AnyObject) {
        if jsonDict is Dictionary<String, AnyObject> {
            
            if let name = jsonDict[API_NAME] as? String, let yearBuilt = jsonDict[API_YEARBUILT] as? String, let location = jsonDict[API_LOCATION] as? String, let photoUrl = jsonDict[API_PHOTO] as? String, let latitudeStr = jsonDict[API_LATITUDE] as? String, let longitudeStr = jsonDict[API_LONGITUDE] as? String  {
                
                //Do the Checks and function calls to get the right data type.
                if let latitude = getDoubleFromString(latitudeStr), let longitude = getDoubleFromString(longitudeStr), let photo = getUIImageFromURL(photoUrl) {
                    
                    //Create a WonderSite instance and populate the WonderSites array.
                    let wonderSite = WonderSite(name: name, yearBuilt: yearBuilt, location: location, photo: photo, latitude: latitude, longitude: longitude)
                    _wonderSites.append(wonderSite)
                }
                
               
                
            }
            
        }
    }
    
    //Mark: - Retrieve an image from a URL
    //NOTE: This can take a long time depending on the size of the image.
    private func getUIImageFromURL(urlStr: String) -> UIImage? {
        if let url = NSURL(string: urlStr) {
            if let data = NSData(contentsOfURL: url) {
                let img = UIImage(data: data)
                return img
            }
        }
        return nil
    }
    
    //Mark: - Turns a String into a Double
    private func getDoubleFromString(str: String) -> Double? {
        if let number = Double(str) {
            return number
        } else {
            return nil
        }
    }
    
    //Mark: - Send out the Notification
    private func sendNotificationOut() {
        NSNotificationCenter.defaultCenter().postNotificationName(API_NOTIFY, object: self)
    }
}