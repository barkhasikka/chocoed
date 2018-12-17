//
//  urlsOfAPICalls.swift
//  chocoed
//
//  Created by Tejal on 21/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import Foundation

let sendOtpApiURL = "https://chocoed.com/development/admin/api/user/sendOtp"
let getUserInfo = "https://chocoed.com/development/admin/api/user/getUserInfo"
let userDropDown = "https://chocoed.com/development/admin/api/user/getDropdownList"
let updateUserInfoURL = "https://chocoed.com/development/admin/api/user/updateUserInfo"
let saveWorkExperience = "https://chocoed.com/development/admin/api/user/saveUserExperience"
let saveEducationExp = "https://chocoed.com/development/admin/api/user/saveUserEducation"
let uploadProfilePicture = "https://chocoed.com/development/admin/api/user/uploadProfilePic"
let getLanguageListCall = "https://chocoed.com/development/admin/api/user/gateLanguageList"
let saveLanguageSelected = "https://chocoed.com/development/admin/api/user/saveUserLanguage"
let accessToken = "03db0f67032a1e3a82f28b476a8b81ea"
let examDetails = "https://chocoed.com/development/admin/api/user/getExamDetail"
let saveUserExamQuestionAnswer = "https://chocoed.com/development/admin/api/user/saveExanQuestionAns"
let endExamAPI = "https://chocoed.com/development/admin/api/user/endExam"
let getMyCourseTopics = "https://chocoed.com/development/admin/api/user/getMyCourseList"
let getMycourseTopicList = "https://chocoed.com/development/admin/api/user/getMyCourseTopicList"
let getMySubTopics = "https://chocoed.com/development/admin/api/user/getMyCourseSubTopicList"

let getCourseData = "https://chocoed.com/development/admin/api/user/getUserCourseDetail"
let getTopicData = "https://chocoed.com/development/admin/api/user/getUserCourseTopicList"
let userTopicsAudit = "https://chocoed.com/development/admin/api/user/userTopicsAudit"
let getProgress = "https://chocoed.com/development/admin/api/user/getMyProgressData"
let examKCDetails = "https://chocoed.com/development/admin/api/user/getKCExamDetail"
let friendList = "https://chocoed.com/development/admin/api/user/getFriendList"
let updateMyProgressFriend = "https://chocoed.com/development/admin/api/user/updateMyProgressFriends"
let saveDeviceToken = "https://chocoed.com/development/admin/api/user/saveDeviceToken"
let getNotificationList = "https://chocoed.com/development/admin/api/user/getNotificationList"

let updateNotificationRead = "https://chocoed.com/development/admin/api/user/updateNotificationRead"
let sendWelcomeNotification = "https://chocoed.com/development/admin/api/user/sendWelcomeNotification"



let empList = "https://chocoed.com/development/admin/api/user/getEmployeeList"

let paymentLink = "https://chocoed.com/development/admin/payment?userId="


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



