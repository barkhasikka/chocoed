//
//  Utils.swift
//  chocoed
//
//  Created by Mahesh Bhople on 07/11/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import UIKit

class Utils: NSObject {
    
    public static func getMsgDate(date : String) -> String {
        
        
        
        if getCurrentData() == getDate(date: date){
            
            // print("Today")
            
            //let dateformat = DateFormatter()
            //dateformat.dateFormat = "hh:mm a"
            //print(dateformat.string(from: Date(milliseconds: Int(date)!)))
            return  "Today"
            
            
        }else{
            
            let dateformat = DateFormatter()
            dateformat.dateFormat = "dd-MMM"
            //print(dateformat.string(from: Date(milliseconds: Int(date)!)))
            return  dateformat.string(from: Date(milliseconds: Int(date)!))
            
        }
        
    }
    
    public static func getDateTimeFromString(date : String) -> String {
        
        // print(date)
        
        
        if getCurrentData() == getDate(date: date){
            
            // print("Today")
            
            let dateformat = DateFormatter()
            dateformat.dateFormat = "hh:mm a"
            let time = dateformat.string(from: Date(milliseconds: Int(date)!))
            return  "Today \(time)"
            
            
        }else{
            
            let dateformat = DateFormatter()
            dateformat.dateFormat = "dd-MMM hh:mm a"
            let time = dateformat.string(from: Date(milliseconds: Int(date)!))
            return  time
            
        }
        
    }
    
    public static func getDateFromString(date : String) -> String {
        
       // print(date)
    
        
        if getCurrentData() == getDate(date: date){
            
           // print("Today")
            
            let dateformat = DateFormatter()
            dateformat.dateFormat = "hh:mm a"
            //print(dateformat.string(from: Date(milliseconds: Int(date)!)))
            return  dateformat.string(from: Date(milliseconds: Int(date)!))
            
            
        }else{
            
            let dateformat = DateFormatter()
            dateformat.dateFormat = "dd-MMM"
            //print(dateformat.string(from: Date(milliseconds: Int(date)!)))
            return  dateformat.string(from: Date(milliseconds: Int(date)!))
         
        }
      
    }
    
    
    public static func getDateFromStringPoll(date : String) -> String {
        
        // print(date)
        
        
        if getCurrentData() == getDate(date: date){
            
            // print("Today")
            
            let dateformat = DateFormatter()
            dateformat.dateFormat = "hh:mm a"
            //print(dateformat.string(from: Date(milliseconds: Int(date)!)))
            return  dateformat.string(from: Date(milliseconds: Int(date)!))
            
            
        }else{
            
            let dateformat = DateFormatter()
            dateformat.dateFormat = "dd-MMM hh:mm a"
            //print(dateformat.string(from: Date(milliseconds: Int(date)!)))
            return  dateformat.string(from: Date(milliseconds: Int(date)!))
            
        }
        
    }
    
    
    public static func getDateTime(date : String) -> String {
        // print(date)
        let dateformat = DateFormatter()
        dateformat.dateFormat = "dd.MM.yyyy hh:mm a"
        // print(dateformat.string(from: Date(milliseconds: Int(date)!)))
        return  dateformat.string(from: Date(milliseconds: Int(date)!))
    }
    
    public static func getDateTimePoll(date : String) -> String {
        print(date)
        let str = date.components(separatedBy: " ")
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd HH:mm:ss"
        // print(dateformat.string(from: Date(milliseconds: Int(date)!)))
        let date1 =  dateformat.date(from: date)
        print(date1!)
        dateformat.dateFormat = "dd-MMM HH:mm"
        return dateformat.string(from: date1!)
    }
    
    
    public static func getDateTimeToDate(date : String) -> Date {
        return  Date(milliseconds: Int(date)!)
    }
    
    
    public static func getTimeFromString(date : String) -> String {
       // print(date)
        let dateformat = DateFormatter()
        dateformat.dateFormat = "hh:mm a"
       // print(dateformat.string(from: Date(milliseconds: Int(date)!)))
        return  dateformat.string(from: Date(milliseconds: Int(date)!))
    }
    
    public static func getDate(date : String) -> String {
        // print(date)
        let dateformat = DateFormatter()
        dateformat.dateFormat = "dd.MM.yyyy"
        // print(dateformat.string(from: Date(milliseconds: Int(date)!)))
        return  dateformat.string(from: Date(milliseconds: Int(date)!))
    }
    
    public static func getCurrentData() -> String{
        
        let date = Date()
        let dateformat = DateFormatter()
        dateformat.dateFormat = "dd.MM.yyyy"
        return  dateformat.string(from: date)

    }

}

extension Date{
    
    var millisecondsSince1970:Int{
        
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds : Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds)/1000)
    }
    
}
