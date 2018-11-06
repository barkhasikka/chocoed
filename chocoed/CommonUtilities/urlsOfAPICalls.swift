//
//  urlsOfAPICalls.swift
//  chocoed
//
//  Created by Tejal on 21/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import Foundation

let sendOtpApiURL = "https://dev.chocoed.com/api/user/sendOtp"
let getUserInfo = "https://dev.chocoed.com/api/user/getUserInfo"
let userDropDown = "https://dev.chocoed.com/api/user/getDropdownList"
let updateUserInfoURL = "https://dev.chocoed.com/api/user/updateUserInfo"
let saveWorkExperience = "https://dev.chocoed.com/api/user/saveUserExperience"
let saveEducationExp = "https://dev.chocoed.com/api/user/saveUserEducation"
let uploadProfilePicture = "https://dev.chocoed.com/api/user/uploadProfilePic"
let getLanguageListCall = "https://dev.chocoed.com/api/user/gateLanguageList"
let saveLanguageSelected = "https://dev.chocoed.com/api/user/saveUserLanguage"
let accessToken = "03db0f67032a1e3a82f28b476a8b81ea"
let examDetails = "https://dev.chocoed.com/api/user/getExamDetail"
let saveUserExamQuestionAnswer = "https://dev.chocoed.com/api/user/saveExanQuestionAns"
let endExamAPI = "https://dev.chocoed.com/api/user/endExam"
let getMyCourseTopics = "https://dev.chocoed.com/api/user/getMyCourseList"
let getMycourseTopicList = "https://dev.chocoed.com/api/user/getMyCourseTopicList"
let getMySubTopics = "https://dev.chocoed.com/api/user/getMyCourseSubTopicList"

let getCourseData = "https://dev.chocoed.com/api/user/getUserCourseDetail"
let getTopicData = "https://dev.chocoed.com/api/user/getUserCourseTopicList"
let userTopicsAudit = "https://dev.chocoed.com/api/user/userTopicsAudit"
let getProgress = "https://dev.chocoed.com/api/user/getMyProgressData"
let examKCDetails = "https://dev.chocoed.com/api/user/getKCExamDetail"
let friendList = "https://dev.chocoed.com/api/user/getFriendList"
let updateMyProgressFriend = "https://dev.chocoed.com/api/user/updateMyProgressFriends"
let saveDeviceToken = "https://dev.chocoed.com/api/user/saveDeviceToken"


var currentTopiceDate  = ""
var currentCourseId  = ""
var currentTopicPosition = -1

var currentSelectedLang = ""


var answerId = -1
var USERDETAILS : UserDetails!
var textfieldMbNumber = ""

var isLoadExamFromVideo = ""
var isLoadExamId = ""
var isLoadCalendarId = ""
var isLoadExamName = ""



