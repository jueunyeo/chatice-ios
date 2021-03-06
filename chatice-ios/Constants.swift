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
        static let messages = [["", "?????????", "?????????", "?????????"], ["?????????", "?????????", "?????????", "?????????"], ["?????????", "?????????", "?????????", "??????"]]
        /*
         static let available = ""
         //static let inavailable = "?????????"
         static let rest = "?????????"
         static let concentrate = "?????????"
         static let sleep = "?????????"
         static let study = "?????????"
         static let work = "?????????"
         static let partTime = "?????????"
         static let exercies = "?????????"
         static let drive = "?????????"
         static let meeting = "?????????"
         static let movie = "?????????"
         static let overseas = "??????"
         */
        
    }
}
