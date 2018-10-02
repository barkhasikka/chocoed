//
//  HttpPostRequest.swift
//  chocoed
//
//  Created by barkha sikka on 21/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import Foundation

func MakeHttpPostRequest(url: String, params: Dictionary<String, String>, completion: @escaping ((_ success: Bool, _ response: NSDictionary) -> Void))  {
    
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
            print(data)
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
               let jsonobject = json as? NSDictionary
                completion( true, jsonobject!)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    task.resume()
    return
}




func MakeHttpMIMEPostRequest(url: String, imageData: NSData, params: Dictionary<String, String>, completion: @escaping ((_ success: Bool, _ response: NSDictionary) -> Void))  {
    
    let url = NSURL(string: url)
    let request = NSMutableURLRequest(url: url! as URL)
    request.httpMethod = "POST"
    let boundary = generateBoundaryString()
    request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    do {
//        let httpBody =  try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
//        let httpBodyString = String(data: httpBody, encoding: String.Encoding.utf8)
//        request.httpBody = httpBodyString?.data(using: String.Encoding.utf8)
        request.httpBody = createBodyWithParameters(parameters: params, imageDataKey: imageData, boundary: boundary) as Data

        
    } catch let error {
        print("error in serialization==",error.localizedDescription)
    }
    
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
            print(data)
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
                let jsonobject = json as? NSDictionary
                completion( true, jsonobject!)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    task.resume()
    return
}

extension String {
    var isBackspace: Bool {
        print("is backspace check", self.cString(using: String.Encoding.utf8))
        let char = self.cString(using: String.Encoding.utf8)!
        return strcmp(char, "\\b") == -92
    }
}

func generateBoundaryString() -> String {
    return "Boundary-\(NSUUID().uuidString)"
}

func createBodyWithParameters(parameters: [String: String]?, imageDataKey: NSData, boundary: String) -> NSData {
    let body = NSMutableData();
    
    if parameters != nil {
        for (key, value) in parameters! {
            body.append(NSString(format: "\r\n--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
            body.append(NSString(format: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n" as NSString).data(using: String.Encoding.utf8.rawValue)!)
            body.append(NSString(format: (value as NSString)).data(using: String.Encoding.utf8.rawValue)!)
        }
    }
    
    
    body.append(NSString(format: "Content-Type: application/octet-stream\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
    body.append(imageDataKey as Data)
    body.append(NSString(format: "\r\n--%@\r\n", boundary).data(using: String.Encoding.utf8.rawValue)!)
    
    return body
}

