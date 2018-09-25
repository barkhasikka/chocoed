//
//  NewWorkModels.swift
//  chocoed
//
//  Created by barkha sikka on 24/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import Foundation

struct NewWorkExperienceTableView {
    var title: String
    init(_ title: String) {
        self.title = title
    }
}

struct FieldsOfWork {
    var id: String
    var name: String
    init(_ dictionary: NSDictionary) {
        print("inside init", dictionary["name"]! as? String ?? "")
        print("inside init", dictionary["id"]! as? String ?? "")
      self.id = dictionary["id"] as? String ?? ""
      self.name = dictionary["name"] as? String ?? ""
    }
}

struct NewEducationExperienceTableView{
    var title : String
    init(_ title : String) {
        self.title = title
    }
}


struct FieldsOfEducation {
    var id : String
    var name : String
    var type : String
    init(_ dictionary : NSDictionary) {
        print("inside init",dictionary["name"]! as? String ?? "")
        print("inside init",dictionary["id"]! as? String ?? "")
        print("inside init",dictionary["type"] as? String ?? "")
        
        self.id = dictionary["id"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.type = dictionary["type"] as? String ?? ""
        
    }
    
}

struct ExistingWorkList {
    var name: String
    var field: String
    var subField: String
    init(_ dictionary : NSDictionary) {
        self.name = dictionary["companyName"] as? String ?? ""
        self.field = dictionary["industrySector"] as? String ?? ""
        self.subField = "\(dictionary["fromYear"] as? String ?? "")\(" to ")\(dictionary["fromYear"] as? String ?? "")\(", ")\(dictionary["teamSize"] as? String ?? "")\(" teams handled")"
        
    }
}

struct ExistingEducationList {
    var name: String
    var field: String
    init(_ dictionary : NSDictionary) {
        self.name = dictionary["educationLevel"] as? String ?? ""
        self.field = "\(dictionary["nameOfInstitute"] as? String ?? ""),\(dictionary["location"] as? String ?? "")\(", ")\(dictionary["yearOfCompletion"] as? String ?? "")"
//            dictionary["nameOfInstitute"] as? String ?? ""
//        "\(dictionary["fromYear"] as? String ?? "")\(" to ")\(dictionary["fromYear"] as? String ?? "")\(", ")\(dictionary["teamSize"] as? String ?? "")\(" teams handled")"
    }
}
