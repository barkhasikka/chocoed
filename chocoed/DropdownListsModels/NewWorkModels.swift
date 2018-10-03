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
    }
}

struct WorkFields {
    var companyName: String
    var fromYear: String
    var functionalDepartment: String
    var id: String
    var industrySector: String
    var levelOfManagement: String
    var status: String
    var teamSize: String
    var toYear: String
    
    init(_ dictionary : NSDictionary? = nil) {
        self.companyName = dictionary?["companyName"] as? String ?? ""
        self.fromYear = dictionary?["fromYear"] as? String ?? ""
        self.functionalDepartment = dictionary?["functionalDepartment"] as? String ?? ""
        self.id = dictionary?["id"] as? String ?? ""
        self.industrySector = dictionary?["industrySector"] as? String ?? ""
        self.levelOfManagement = dictionary?["levelOfManagemet"] as? String ?? ""
        self.status = dictionary?["status"] as? String ?? ""
        self.teamSize = dictionary?["teamSize"] as? String ?? ""
        self.toYear = dictionary?["toYear"] as? String ?? ""
    }
}


struct EducationFields {
    var boardUniversity: String
    var educationLevel: String
    var location: String
    var id: String
    var mediumOfEducation: String
    var nameOfInstitute: String
    var specialisation: String
    var state: String
    var yearOfCompletion: String
    var status: String
    
    init(_ dictionary : NSDictionary? = nil) {
        self.boardUniversity = dictionary?["boardUniversity"] as? String ?? ""
        self.educationLevel = dictionary?["educationLevel"] as? String ?? ""
        self.location = dictionary?["location"] as? String ?? ""
        self.id = dictionary?["id"] as? String ?? ""
        self.mediumOfEducation = dictionary?["mediumOfEducation"] as? String ?? ""
        self.nameOfInstitute = dictionary?["nameOfInstitute"] as? String ?? ""
        self.specialisation = dictionary?["specialisation"] as? String ?? ""
        self.state = dictionary?["state"] as? String ?? ""
        self.yearOfCompletion = dictionary?["yearOfCompletion"] as? String ?? ""
        self.status = dictionary?["status"] as? String ?? ""
    }
}


struct LanguageList {
    var dbname: String
    var id: Int
    var langDispalyName: String
    init(_ dictionary : NSDictionary) {
        self.dbname = dictionary["dbName"] as? String ?? ""
        self.langDispalyName = dictionary["displayName"] as? String ?? ""
        self.id = dictionary["id"] as? Int ?? -1
        
    }
}

struct BehaviouralQuestion{
    var questionName: String
    var anstype: Int
    var answerSubmitted : String
    var id : Int
    
    var option : NSArray
    init(_ dictionary : NSDictionary) {
        self.questionName = dictionary["name"] as? String ?? ""
        self.answerSubmitted = dictionary["isAnsSubmitted"] as? String ?? ""
        self.anstype = dictionary["ansType"] as? Int ?? -1
        self.id = dictionary["id"] as? Int ?? -1
        self.option = dictionary["optionList"] as? NSArray ?? []
    }

}

struct BehaviouralOption {
    var ansImageUrl : String
    var ansText: String
    var id : Int

    init(_ dictionary : NSDictionary) {
        self.ansImageUrl = dictionary["ansImageUrl"] as? String ?? ""
        self.ansText = dictionary["ansText"] as? String ?? ""
        self.id = dictionary["id"] as? Int ?? -1

    }

}
