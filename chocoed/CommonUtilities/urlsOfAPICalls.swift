//
//  urlsOfAPICalls.swift
//  chocoed
//
//  Created by Tejal on 21/09/18.
//  Copyright © 2018 barkha sikka. All rights reserved.
//

import Foundation

let sendOtpApiURL = "https://chocoed.com/admin/api/user/sendOtp"
let getUserInfo = "https://chocoed.com/admin/api/user/getUserInfo"
let userDropDown = "https://chocoed.com/admin/api/user/getDropdownList"
let updateUserInfoURL = "https://chocoed.com/admin/api/user/updateUserInfo"
let saveWorkExperience = "https://chocoed.com/admin/api/user/saveUserExperience"
let saveEducationExp = "https://chocoed.com/admin/api/user/saveUserEducation"
let uploadProfilePicture = "https://chocoed.com/admin/api/user/uploadProfilePic"
let getLanguageListCall = "https://chocoed.com/admin/api/user/gateLanguageList"
let saveLanguageSelected = "https://chocoed.com/admin/api/user/saveUserLanguage"
let accessToken = "03db0f67032a1e3a82f28b476a8b81ea"
let examDetails = "https://chocoed.com/admin/api/user/getExamDetail"
let saveUserExamQuestionAnswer = "https://chocoed.com/admin/api/user/saveExanQuestionAns"
let endExamAPI = "https://chocoed.com/admin/api/user/endExam"
let getMyCourseTopics = "https://chocoed.com/admin/api/user/getMyCourseList"
let getMycourseTopicList = "https://chocoed.com/admin/api/user/getMyCourseTopicList"
let getMySubTopics = "https://chocoed.com/admin/api/user/getMyCourseSubTopicList"

let getCourseData = "https://chocoed.com/admin/api/user/getUserCourseDetail"
let getTopicData = "https://chocoed.com/admin/api/user/getUserCourseTopicList"
let userTopicsAudit = "https://chocoed.com/admin/api/user/userTopicsAudit"
let getProgress = "https://chocoed.com/admin/api/user/getMyProgressData"
let examKCDetails = "https://chocoed.com/admin/api/user/getKCExamDetail"
let friendList = "https://chocoed.com/admin/api/user/getFriendList"
let updateMyProgressFriend = "https://chocoed.com/admin/api/user/updateMyProgressFriends"
let saveDeviceToken = "https://chocoed.com/admin/api/user/saveDeviceToken"
let getNotificationList = "https://chocoed.com/admin/api/user/getNotificationList"

let updateNotificationRead = "https://chocoed.com/admin/api/user/updateNotificationRead"
let sendWelcomeNotification = "https://chocoed.com/admin/api/user/sendWelcomeNotification"

let pollApi = "https://www.chocoed.com/admin/api/user/getPollList"
let pollResult = "https://www.chocoed.com/admin/api/user/getPollResult"


let empList = "https://chocoed.com/admin/api/user/getEmployeeList"

let paymentLink = "https://chocoed.com/admin/payment?userId="

let savepoll = "https://www.chocoed.com/admin/api/user/savePollVote"
let ChecksumGeneration = "https://www.chocoed.com/admin/api/user/ChecksumGeneration"


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



