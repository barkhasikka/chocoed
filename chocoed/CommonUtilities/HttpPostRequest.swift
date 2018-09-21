//
//  HttpPostRequest.swift
//  chocoed
//
//  Created by barkha sikka on 21/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import Foundation

func MakeHttpPostRequest(url: String, params: Dictionary<String, String>) ->  NSDictionary {
    var jsonobject: NSDictionary!
    
    let url = NSURL(string: url)
    let request = NSMutableURLRequest(url: url! as URL)
    request.httpMethod = "POST"
    do {
        let httpBody =  try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
        let httpBodyString = String(data: httpBody, encoding: String.Encoding.utf8)
        request.httpBody = httpBodyString?.data(using: String.Encoding.utf8)
        
    } catch let error {
        print("error in serialization==",error.localizedDescription)
    }
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    let session = URLSession.shared
    let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
        guard error == nil else {
            print("error in the request", error ?? "")
            return
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            let statusCode = httpResponse.statusCode
            print("Status Code for url \(String(describing: url))", statusCode)
        }
        guard let data = data else {
            print("something is wrong")
            return
        }
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                jsonobject = json["result"] as? NSDictionary
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    task.resume()
    return jsonobject
}

