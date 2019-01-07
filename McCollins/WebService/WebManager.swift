//
//  WebManager.swift
//  McCollins
//
//  Created by Da Chen on 1/6/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

import UIKit
import Foundation

class WebManager {
    static let shared = WebManager()
    
    private init() {}
    
    func checkLogin(email: String, pwd: String, completion: @escaping ([[String : Any]])->()) {
        let urlStr = "http://mccollinsmedia.com/myproject/service/checklogin"
        let url = URL(string: urlStr)
        
        var json = [String:Any]()
        
        json["email"] = email
        json["password"] = pwd
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.httpBody = data
            
            _ = URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    if let allData = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any] {
                        if let userInfo = allData["data"] as? [[String : Any]] {
                            completion(userInfo)
                        } else {
                            completion([])
                        }
                    } else {
                        completion([])
                    }
                } catch {
                    completion([])
                }
            }.resume()
        }catch{
            completion([])
        }
    }
    
    func submitForm(form: Form, completion: @escaping (Bool)->()) {
        let urlStr = "http://mccollinsmedia.com/myproject/service/registerUser"
        let url = URL(string: urlStr)
        
        var json = [String:Any]()
        
        json["fname"] = form.firstName!
        json["lname"] = form.lastName!
        json["email"] = form.emailId!
        json["mobile"] = form.phone!
        json["password"] = form.password!
        json["cpassword"] = form.cpassword!
        json["dob"] = form.dob!
        json["gender"] = form.gender!
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.httpBody = data
            
            _ = URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    if let allData = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any] {
                        if let isError = allData["iserror"] as? String {
                            if isError == "Yes" {
                                completion(true)
                            } else {
                                completion(false)
                            }
                        }
                    } else {
                        completion(true)
                    }
                } catch {
                    completion(true)
                }
                }.resume()
        }catch{
            completion(true)
        }
    }
    
    func getAttractions(email: String, completion: @escaping ([[String : Any]])->()) {
        let urlStr = "http://mccollinsmedia.com/myproject/service/listAttractions"
        let url = URL(string: urlStr)
        
        var json = [String:Any]()
        json["email"] = email
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: [])
            
            var request = URLRequest(url: url!)
            request.httpMethod = "POST"
            request.httpBody = data
            
            _ = URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    if let allData = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any] {
                        if let attractionList = allData["data"] as? [[String : Any]] {
                            completion(attractionList)
                        } else {
                            completion([])
                        }
                    } else {
                        completion([])
                    }
                } catch {
                    completion([])
                }
            }.resume()
        }catch{
            completion([])
        }
    }
    
    func getImgs(imgUrl: String) -> UIImage? {
        let url = URL(string: imgUrl)
        
        if let urlUnwrapped = url {
            do {
                let imgData = try Data(contentsOf: urlUnwrapped)
                return UIImage(data: imgData)
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
}
