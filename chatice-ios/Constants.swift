//
//  Constants.swift
//  chatice-ios
//
//  Created by admin on 2/24/22.
//

struct K {
    struct UserInfo {
        static let collectionName = "userInfo"
        static let phoneNumberField = "phoneNumber" //String
        //static let locationField = "location"
        static let nicknameField = "nickname"   //String
        static let profileExistField = "profileExist" //Bool
        static let statusField = "status"   //Bool
        static let statusMessageField = "statusMessage" //String
        
        static let friendField = "friend"   //[String] ([userId])
        static let followingField = "following" //[String] ([userId])
        static let followerField = "follower"   //[String] ([userId])
        static let friendGroupField = "friendGroup" //[String:[String]] ([title:[userId]])
    }
    struct Chat {
        static let collectionName = "chat"
        static let senderField = "sender"   //sender user uid
        static let destinationField = "destination" //chat room uid
        static let dateField = "date"   //Date()
        static let typeField = "type"   //Int 0: text, 1: image
        static let bodyField = "body"
        static let readField = "read"   //[String] ([unread member uid])
        static let totalReadField = "totalRead" //true if all memebers read
    }
    struct ChatRoom {
        static let collectionName = "chatRoom"
        static let custumTitleField = "customTitle"
        static let memberField = "member"
        //static let contentField = "content" //[chat id: date]
        static let recentContentBodyField = "recentContentBody"
        static let recentContentDateField = "recentContentDate"
        static let readField = "read"   //[String: Int] ([member: unreadM])
    }
    struct ShortNote {
        static let collectionName = "shortNote"
        static let senderField = "sender"
        static let destinationField = "destination" //destination user uids
        static let dateField = "date"   //Date()
        static let textBodyField = "textBody"
        static let imageBodyField = "imageBody"
        static let readField = "read"
        static let likeField = "like"
    }
    struct AlarmMessage {
        static let collectionName = "alarmMessage"
    }
    struct StatusMessage {
        static let messages = [["", "휴식중", "집중중", "수면중"], ["공부중", "업무중", "알바중", "운동중"], ["운전중", "회의중", "영화관", "해외"]]
        /*
         static let available = ""
         //static let inavailable = "부재중"
         static let rest = "휴식중"
         static let concentrate = "집중중"
         static let sleep = "수면중"
         static let study = "공부중"
         static let work = "업무중"
         static let partTime = "알바중"
         static let exercies = "운동중"
         static let drive = "운전중"
         static let meeting = "회의중"
         static let movie = "영화관"
         static let overseas = "해외"
         */
        
    }
}
