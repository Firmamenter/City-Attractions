//
//  WebParser.swift
//  McCollins
//
//  Created by Da Chen on 1/6/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

import Foundation

class WebParser {
    static let shared = WebParser()
    
    private init() {}
    
    func parseUserInfo(jsonObj: [[String : Any]]) {
        UserDefaults.standard.set(true, forKey: "LoggedIn")
        if let firstName = jsonObj[0]["fname"] as? String {
            UserDefaults.standard.set(firstName, forKey: "FirstName")
        }
        if let lastName = jsonObj[0]["lname"] as? String? {
            UserDefaults.standard.set(lastName, forKey: "LastName")
        }
        if let email = jsonObj[0]["email"] as? String {
            UserDefaults.standard.set(email, forKey: "Email")
        }
        if let phone = jsonObj[0]["mobile"] as? String {
            UserDefaults.standard.set(phone, forKey: "Phone")
        }
        if let pwd = jsonObj[0]["password"] as? String {
            UserDefaults.standard.set(pwd, forKey: "Password")
        }
        if let dob = jsonObj[0]["dob"] as? String {
            UserDefaults.standard.set(dob, forKey: "Dob")
        }
        if let gender = jsonObj[0]["gender"] as? String {
            UserDefaults.standard.set(gender, forKey: "Gender")
        }
        if let userImg = jsonObj[0]["userimage"] as? String {
            UserDefaults.standard.set(userImg, forKey: "UserImg")
        }
    }
    
    func parseAttractions(jsonObj: [[String : Any]]) -> [AttractionDetail]? {
        var result : [AttractionDetail]? = []
        
        for attraction in jsonObj {
            if let title = attraction["title"] as? String,
                let description = attraction["description"] as? String,
                let contact = attraction["contact"] as? String,
                let timing = attraction["timing"] as? String,
                let sitelink = attraction["sitelink"] as? String,
                let latitude = attraction["latitude"] as? String,
                let longitude = attraction["longitude"] as? String,
                let image = attraction["image"] as? String {
                let obj = AttractionDetail(title: title, description: description, contact: contact, timing: timing, sitelink: sitelink, image: image, latitude: latitude, longitude: longitude)
                result?.append(obj)
            }
        }
        return result
    }
}
