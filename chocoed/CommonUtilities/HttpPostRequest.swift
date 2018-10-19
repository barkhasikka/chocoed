//
//  HttpPostRequest.swift
//  chocoed
//
//  Created by barkha sikka on 21/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import Foundation
import UIKit
func MakeHttpPostRequest(url: String, params: Dictionary<String, String>, completion: @escaping ((_ success: Bool, _ response: NSDictionary) -> Void), errorHandler: @escaping ((_ message: String) -> Void))  {

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
                if jsonobject?.value(forKey: "statusCode") as! Int == 0 {
                    errorHandler(jsonobject?.value(forKey: "statusMessage") as! String)
                }else {
                    completion( true, jsonobject!)
                }
            }
        } catch let error {
            print(error.localizedDescription)
            errorHandler(error.localizedDescription)
        }
    }
    task.resume()
    return
}


func MakeHttpMIME2PostRequest(url: String, imageData: NSData, param: Dictionary<String, String>, completion: @escaping ((_ success: Bool, _ response: NSDictionary) -> Void)) {
    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = "POST"
    let boundary = generateBoundaryString()
    
    let uuid = NSUUID().uuidString

    
    request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "file", imageDataKey: imageData, boundary: boundary) as Data
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
}

//
//func MakeHttpMIMEPostRequest(url: String, imageData: NSData, params: Dictionary<String, String>, completion: @escaping ((_ success: Bool, _ response: NSDictionary) -> Void))  {
//
//    let url = NSURL(string: url)
//    let request = NSMutableURLRequest(url: url! as URL)
//    request.httpMethod = "POST"
//    let boundary = generateBoundaryString()
//     request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//    request.httpBody = createBodyWithParameters(parameters:params, filePathKey: "file", imageDataKey: imageData, boundary: boundary) as Data
//    let session = URLSession.shared
//    let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
//        guard error == nil else {
//            print("error in the request", error ?? "")
//            return
//        }
//
//        if let httpResponse = response as? HTTPURLResponse {
//            let statusCode = httpResponse.statusCode
//            print("Status Code for url \(String(describing: url))", statusCode)
//        }
//        guard let data = data else {
//            print("something is wrong")
//            return
//        }
//
//        do {
//            print(data)
//            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] {
//                let jsonobject = json as? NSDictionary
//                completion( true, jsonobject!)
//            }
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//    task.resume()
//
//}

extension String {
    var isBackspace: Bool {
        print("is backspace check", self.cString(using: String.Encoding.utf8))
        let char = self.cString(using: String.Encoding.utf8)!
        return strcmp(char, "\\b") == -92
    }
}

//func generateBoundaryString() -> String {
//    return "Boundary-\(NSUUID().uuidString)"
//}
//
//func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
//    let body = NSMutableData();
//
//    if parameters != nil {
//        for (key, value) in parameters! {
//
//            body.append(NSString(string:"--\(boundary)\r\n").data(using: String.Encoding.utf8.rawValue)!)
//            body.append(NSString(string:"Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n").data(using: String.Encoding.utf8.rawValue)!)
//            body.append(NSString(string:"\(value)\r\n").data(using: String.Encoding.utf8.rawValue)!)
//
//        }
//    }
//
////    let filename = "user-profile.jpg"
////    let mimetype = "image/jpg"
//
//    body.append(NSString(string:"--\(boundary)\r\n").data(using:String.Encoding.utf8.rawValue)!)
//    body.append(NSString(string:"Content-Disposition: form-data; name=\"\(filePathKey!)\" \r\n").data(using:String.Encoding.utf8.rawValue)!)
//    body.append(imageDataKey as Data)
////    body.append(NSString(string: "Content-Type: \(mimetype)\r\n\r\n").data(using:String.Encoding.utf8.rawValue)!)
//
//    body.append(NSString(string:"\r\n").data(using: String.Encoding.utf8.rawValue)!)
//
//
//
//    body.append(NSString(string:"--\(boundary)--\r\n").data(using:String.Encoding.utf8.rawValue)!)
//
//    return body
//}

func createBodyWithParameters(parameters: [String:String], filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
    let body = NSMutableData();
    
    if parameters != nil {
        for (key, value) in parameters {
            print(key, value, "BLHA BLAH BLAH=====")
            body.appendString(string: "--\(boundary)\r\n")
            body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString(string: "\(value)\r\n")
        }
    }
    let uuid = NSUUID().uuidString + ".jpg"
    let mimetype = "image/jpg"
    
    body.appendString(string: "--\(boundary)\r\n")
    
    
//    let imageData = UIImageJPEGRepresentation(img, 1)
    body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(uuid)\"\r\n")
    body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
    body.append(imageDataKey as Data)
    body.appendString(string: "\r\n")
    body.appendString(string: "--\(boundary)--\r\n")
    return body
}



func generateBoundaryString() -> String {
    return "Boundary-\(NSUUID().uuidString)"
}

extension NSMutableData {
    
    func appendString(string : String)
    {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

func GetAlertWithOKAction(message: String) -> UIViewController {
    let alertcontrol = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
    let alertaction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertcontrol.addAction(alertaction)
    return alertcontrol
}

