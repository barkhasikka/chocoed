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
    init(_ dictionary : NSDictionary? = nil) {
        self.dbname = dictionary!["dbName"] as? String ?? ""
        self.langDispalyName = dictionary!["displayName"] as? String ?? ""
        self.id = dictionary!["id"] as? Int ?? -1
        
    }
}

struct Question{
    var questionName: String
    var anstype: String
    var answerSubmitted : Int
    var id : String
    var selectedAns: String
    
    var option : NSArray
    var questionList : NSArray
    
    var correctAnsId: String

    var selectedAnsId : String
    
    init(_ dictionary : NSDictionary) {
        self.questionName = dictionary["name"] as? String ?? ""
        self.answerSubmitted = dictionary["isAnsSubmitted"] as? Int ?? 0
        self.anstype = dictionary["ansType"] as? String ?? ""
        self.id = dictionary["id"] as? String ?? ""
        self.selectedAns = dictionary["selectedAns"] as? String ?? ""
        self.option = dictionary["optionList"] as? NSArray ?? []
        self.questionList = dictionary["question_image_list"] as? NSArray ?? []
        self.correctAnsId = dictionary["correctAnsId"] as? String ?? ""
        self.selectedAnsId = dictionary["selectedAnsId"] as? String ?? ""


    }

}

struct Option {
    var ansImageUrl : String
    var ansText: String
    var id : String

    init(_ dictionary : NSDictionary) {
        self.ansImageUrl = dictionary["ansImageUrl"] as? String ?? ""
        self.ansText = dictionary["ansText"] as? String ?? ""
        self.id = dictionary["id"] as? String ?? ""

    }

}

struct CourseList{
    var calenderId : String
    var courseId : String
    var courseImageUrl : String
    var courseName : String
    var startdate : String
    var enddate : String
    init(_ dictionary : NSDictionary) {
        
        self.calenderId = dictionary["calenderId"] as? String ?? ""
        self.courseId = dictionary["courseId"] as? String ?? ""
        self.courseImageUrl = dictionary["courseImageUrl"] as? String ?? ""
        self.courseName = dictionary["courseName"] as? String ?? ""
        self.startdate = dictionary["startDate"] as? String ?? ""
        self.enddate = dictionary["endDate"] as? String ?? ""
    }
    
}
struct CourseTopicList{
    var topicName : String
    var topicId: String
    var subTopicCount : Int
    var testCount : Int
    
    init(_ dictionary : NSDictionary) {
        self.topicName = dictionary["topicName"] as? String ?? ""
        self.topicId = dictionary["topicId"] as? String ?? ""
        self.subTopicCount = dictionary["subTopicCount"] as? Int ?? 0
        self.testCount = dictionary["testCount"] as? Int ?? 0
    }
}

struct CourseSubTopicList{
    var calenderId : String
    var calenderName : String
    var examId : String
    var examName : String
    var examStatus : String
    var subTopicName : String
    var topicId : Int
    var topicLayouts : NSArray
    var topicName : String
    var topicStatus : String
    var topicVideoUrl : String
    var videoViewCount : Int
    var videoViewLimit : Int
    
    
    init(_ dictionary : NSDictionary) {
        self.calenderId = dictionary["calenderId"] as? String ?? ""
        self.calenderName = dictionary["calenderName"] as? String ?? ""
        self.examId = dictionary["examId"] as? String ?? ""
        self.examName = dictionary["examName"] as? String ?? ""
        self.examStatus = dictionary["examStatus"] as? String ?? ""
        self.subTopicName = dictionary["subTopicName"] as? String ?? ""
        self.topicId = dictionary["topicId"] as? Int ?? -1
        self.topicLayouts = dictionary["topicLayouts"] as? NSArray ?? []
        self.topicName = dictionary["topicName"] as? String ?? ""
        self.topicStatus = dictionary["topicStatus"] as? String ?? ""
        self.topicVideoUrl = dictionary["topicVideoUrl"] as? String ?? ""
        self.videoViewCount = dictionary["videoViewCount"] as? Int ?? 0
        self.videoViewLimit = dictionary["videoViewLimit"] as? Int ?? 3
    }
    
}
struct UserDetails{
    var email : String
    var firstName : String
    var lastname : String
    var imageurl : String
    var mobile : String

}



struct ExamList {
    var examId: String
    var examName: String
    var examStatus: String
    var calenderId: String

    init(_ dictionary : NSDictionary) {
        self.examId = dictionary["examId"] as? String ?? ""
        self.examName = dictionary["examName"] as? String ?? ""
        self.examStatus = dictionary["examStatus"] as? String ?? ""
        self.calenderId = dictionary["calenderId"] as? String ?? ""

    }
}

struct KnowledgeList {
    var examId: String
    var examName: String
    var videoPosition: Float
    init(_ dictionary : NSDictionary) {
        self.examId = dictionary["examId"] as? String ?? ""
        self.examName = dictionary["examName"] as? String ?? ""
        self.videoPosition = Float(dictionary["videoPosition"] as? String ?? "")!
    }
}


struct TopicList{
    
    var calenderId : String
    var calenderName : String
    var examId : String
    var examName : String
    var examStatus : String
    var subTopicName : String
    var topicId : String
    var topicName : String
    var topicLayouts : NSArray
    var topicStatus : String
    var topicVideoUrl : String
    var videoViewCount : Int
    var videoViewLimit : Int
    var videoPosition : String
    var isBlock : Bool
    
    
    init(_ dictionary : NSDictionary) {
        
        self.calenderId = dictionary["calenderId"] as? String ?? ""
        self.calenderName = dictionary["calenderName"] as? String ?? ""
        self.examId = dictionary["examId"] as? String ?? ""
        self.examName = dictionary["examName"] as? String ?? ""
        self.examStatus = dictionary["examStatus"] as? String ?? ""
        self.subTopicName = dictionary["subTopicName"] as? String ?? ""
        self.topicId = dictionary["topicId"] as? String ?? ""
        self.topicName = dictionary["topicName"] as? String ?? ""
        self.topicStatus = dictionary["topicStatus"] as? String ?? ""
        self.topicVideoUrl = dictionary["topicVideoUrl"] as? String ?? ""
        self.videoViewCount = dictionary["videoViewCount"] as? Int ?? -1
        self.videoViewLimit = dictionary["videoViewLimit"] as? Int ?? -1
        self.videoPosition = dictionary["videoPosition"] as? String ?? ""
        self.topicLayouts = dictionary["topicLayouts"] as? NSArray ?? []
        self.isBlock = false
    }
    
}

struct getMyProgressStruct{
    var myTopicCount : Int
    var myTestCount : Int
    var myWeekNumber : Int
    var myRankNumber : Int
    var schduleMsg : String
    var friendList : NSArray
    var myCoursesCount: Int
    var myBadgeCount : Int

    

    init(_ dictionary : NSDictionary) {
        
        self.myBadgeCount = dictionary["myBadgeCount"] as? Int ?? 0
        self.myTopicCount = dictionary["myTopicCount"] as? Int ?? 0
        self.myWeekNumber = dictionary["myWeekNumber"] as? Int ?? 0
        self.myTestCount = dictionary["myTestCount"] as? Int ?? 0
        self.myRankNumber = dictionary["myRankNumber"] as? Int ?? 0
        self.schduleMsg = dictionary["scheduleMessage"] as? String ?? ""
        self.friendList = dictionary["friendList"] as? NSArray ?? []
        self.myCoursesCount = dictionary["myCoursesCount"] as? Int ?? 0
}
}

struct FriendProgress{
    var friendId : Int
    var friendImageUrl : String
    var friendName : String
    var rankNumber : Int
    var testCount : Int
    var topicCount : Int
    var weekNumber: Int
    var badgesCount: Int

    
    init(_ dictionary : NSDictionary) {
        self.friendId = dictionary["friendId"] as? Int ?? 0
        self.friendImageUrl = dictionary["friendImageUrl"] as? String ?? ""
        self.friendName = dictionary["friendName"] as? String ?? ""
        self.rankNumber = dictionary["rankNumber"] as? Int ?? 0
        self.testCount = dictionary["testCount"] as? Int ?? 0
        self.topicCount = dictionary["topicCount"] as? Int ?? 0
        self.weekNumber = dictionary["weekNumber"] as? Int ?? 0
        self.badgesCount = dictionary["badgeCount"] as? Int ?? 0

        
    }
    
}

struct FriendList{
    
    var friendId : String
    var friendImageUrl : String
    var friendName : String
    var mobile : String
    var selected : Bool
    var fcmToken : String
    var deviceType : String


    
    init(_ dictionary : NSDictionary) {
        self.friendId = dictionary["friendId"] as? String ?? ""
        self.friendImageUrl = dictionary["friendImageUrl"] as? String ?? ""
        self.friendName = dictionary["friendName"] as? String ?? ""
        self.selected = dictionary["selected"] as? Bool ?? false
        self.mobile = dictionary["mobile"] as? String ?? ""
        self.fcmToken = dictionary["fcmToken"] as? String ?? ""
        self.deviceType = dictionary["deviceType"] as? String ?? ""


    }
    
}

struct FriendItem{
    var friendId : Int
    var friendName : String
    
    init(_ dictionary : NSDictionary) {
        self.friendId = dictionary["friendId"] as? Int ?? 0
        self.friendName = dictionary["friendName"] as? String ?? ""
    }
    
}


struct FriendListUpdate{
    var friendId : String
    var friendName : String
    
    init(id: String, name: String) {
        self.friendId = id
        self.friendName = name
    }
    
}

struct getNotificationListStruct{
    var aboutNotification : String
    var isRead : Bool
    var notificationDate : Int
    var notificationId : String
    var notificationImageUrl : String
    var notificationTitle : String
    var notificationType: String
    
    init(_ dictionary : NSDictionary) {
        self.aboutNotification = dictionary["aboutNotification"] as? String ?? ""
        self.isRead = dictionary["isRead"] as? Bool ?? false
        self.notificationDate = dictionary["notificationDate"] as? Int ?? 0
        self.notificationId = dictionary["notificationId"] as? String ?? ""
        self.notificationImageUrl = dictionary["notificationImageUrl"] as? String ?? ""
        self.notificationTitle = dictionary["notificationTitle"] as? String ?? ""
        self.notificationType = dictionary["notificationType"] as? String ?? ""
}
}
