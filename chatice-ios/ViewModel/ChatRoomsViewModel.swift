//
//  ChatRoomsViewModel.swift
//  chatice-ios
//
//  Created by admin on 2/26/22.
//

import Foundation
import Firebase

struct ChatRoom {
    let uid: String
    let customTitle: String
    let member: [Friend]
    let recentContentBody: String
    let recentContentDate: Date
    let read: [String:Int]
}

class ChatRoomsViewModel: ObservableObject {
    @Published var chatRooms: [ChatRoom] = []
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    /*
     func loadChatRooms(userId: String) {
         self.db.collection(K.ChatRoom.collectionName).whereField(K.ChatRoom.memberField, arrayContains: userId).addSnapshotListener {(querySnapshot, error) in
             self.chatRooms = []
             if let e = error {
                 print("There was an issue get data from Firestore. \(e)")
             } else {
                 if let snapshotDocuments = querySnapshot?.documents {
                     for doc in snapshotDocuments {
                         let newUid = doc.documentID
                         let data = doc.data()
                         if let newCustomTitle = data[K.ChatRoom.custumTitleField] as? String,
                            let newMember = data[K.ChatRoom.memberField] as? [String],
                            let newRecentContentBody = data[K.ChatRoom.recentContentBodyField] as? String,
                            let newRecentContentDate = data[K.ChatRoom.recentContentDateField] as? Date,
                            let newRead = data[K.ChatRoom.readField] as? [String:Int] {
                             self.db.collection(K.UserInfo.collectionName).getDocuments {(querySnapshot, error) in
                                 var newMemberFriend:[Friend] = []
                                 if let e = error {
                                     print("There was an issue get data from Firestore. \(e)")
                                 } else {
                                     if let snapshotDocuments = querySnapshot?.documents {
                                         for doc in snapshotDocuments {
                                             let docId = doc.documentID
                                             if newMember.contains(docId) {
                                                 let newUid = doc.documentID
                                                 let data = doc.data()
                                                 if let newPhoneNumber = data[K.UserInfo.phoneNumberField] as? String,
                                                    let newNickname = data[K.UserInfo.nicknameField] as? String,
                                                    let newProfile = data[K.UserInfo.profileField] as? String,
                                                    let newStatus = data[K.UserInfo.statusField] as? Bool,
                                                    let newStatusMessage = data[K.UserInfo.statusMessageField] as? String {
                                                     let newFriend = Friend(uid: newUid, phoneNumber: newPhoneNumber, nickname: newNickname, profile: newProfile, status: newStatus, statusMessage: newStatusMessage)
                                                     newMemberFriend.append(newFriend)
                                                 }
                                             }
                                         }
                                         let newChatRoom = ChatRoom(uid: newUid, customTitle: newCustomTitle, member: newMemberFriend, recentContentBody: newRecentContentBody, recentContentDate: newRecentContentDate, read: newRead)
                                         self.chatRooms.append(newChatRoom)
                                     }
                                 }
                             }
                         }
                     }
                 }
             }
         }
     }
     */
    
       
    
    func addChatRoom() {
        
    }
    
    func deleteChateRoom() {
        
    }
}
