//
//  urlsOfAPICalls.swift
//  chocoed
//
//  Created by Tejal on 21/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import Foundation

let sendOtpApiURL = "http://dev.chocoed.com/api/user/sendOtp"
let getUserInfo = "http://dev.chocoed.com/api/user/getUserInfo"
let userDropDown = "http://dev.chocoed.com/api/user/getDropdownList"
let updateUserInfoURL = "http://dev.chocoed.com/api/user/updateUserInfo"
let saveWorkExperience = "http://dev.chocoed.com/api/user/saveUserExperience"
let saveEducationExp = "http://dev.chocoed.com/api/user/saveUserEducation"
let uploadProfilePicture = "http://dev.chocoed.com/api/user/uploadProfilePic"
let getLanguageListCall = "http://dev.chocoed.com/api/user/gateLanguageList"
let saveLanguageSelected = "http://dev.chocoed.com/api/user/saveUserLanguage"
let accessToken = "03db0f67032a1e3a82f28b476a8b81ea"
let examDetails = "http://dev.chocoed.com/api/user/getExamDetail"
let saveUserExamQuestionAnswer = "http://dev.chocoed.com/api/user/saveExanQuestionAns"
let endExamAPI = "http://dev.chocoed.com/api/user/endExam"
let getMyCourseTopics = "http://dev.chocoed.com/api/user/getMyCourseList"
let getMycourseTopicList = "http://dev.chocoed.com/api/user/getMyCourseTopicList"
let getMySubTopics = "http://dev.chocoed.com/api/user/getMyCourseSubTopicList"

let getCourseData = "http://dev.chocoed.com/api/user/getUserCourseDetail"
let getTopicData = "http://dev.chocoed.com/api/user/getUserCourseTopicList"
let userTopicsAudit = "http://dev.chocoed.com/api/user/userTopicsAudit"
let getProgress = "http://dev.chocoed.com/api/user/getMyProgressData"


var currentTopiceDate  = ""
var currentCourseId  = ""
var currentTopicPosition = -1

var currentSelectedLang = ""


var answerId = -1
var USERDETAILS : UserDetails!
var textfieldMbNumber = ""

