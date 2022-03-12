//
//  ChatRoomViewModel.swift
//  chatice-ios
//
//  Created by admin on 2/23/22.
//

import Foundation
import Firebase

struct Chat {
    let uid: String
    let sender: Friend
    let destination: String
    let date: Date
    let type: Int
    let body: String
    var raed: [String]
    var totalRead: Bool
}

/*
 class ChatRoomViewModel: ObservableObject {
     @Published var chat: [Chat] = []
     
     let db = Firestore.firestore()
     let storage = Storage.storage()
     var listener : ListenerRegistration!
     
     func loadChatRoom(chatRoomId: String) {
         self.listener = self.db.collection(K.Chat.collectionName).whereField(K.Chat.destinationField, isEqualTo: chatRoomId).order(by: K.Chat.dateField).addSnapshotListener {(querySnapshot, error) in
             self.chat = []
             if let e = error {
                 print("There was an issue get data from Firestore. \(e)")
             } else {
                 if let snapshotDocuments = querySnapshot?.documents {
                     for doc in snapshotDocuments {
                         let docId = doc.documentID
                         let data = doc.data()
                         if let newSender = data[K.Chat.senderField] as? String,
                            let newDestination = data[K.Chat.destinationField] as? String,
                            let newDate = data[K.Chat.dateField] as? Date,
                            let newType = data[K.Chat.typeField] as? Int,
                            let newBody = data[K.Chat.bodyField] as? String,
                            let newRead = data[K.Chat.readField] as? [String],
                            let newTotalRead = data[K.Chat.totalReadField] as? Bool {
                             self.db.collection(K.UserInfo.collectionName).document(newSender).getDocument() { (documentSnapshot, error) in
                                 var newSenderFriend: [Friend] = []
                                 if let e = error {
                                     print("There was an issue get data from Firestore. \(e)")
                                 } else {
                                     if let document = documentSnapshot {
                                         let newUid = document.documentID
                                         if let data = document.data() {
                                             if let newPhoneNumber = data[K.UserInfo.phoneNumberField] as? String,
                                                let newNickname = data[K.UserInfo.nicknameField] as? String,
                                                let newProfile = data[K.UserInfo.profileField] as? String,
                                                let newStatus = data[K.UserInfo.statusField] as? Bool,
                                                let newStatusMessage = data[K.UserInfo.statusMessageField] as? String {
                                                 let newFriend = Friend(uid: newUid, phoneNumber: newPhoneNumber, nickname: newNickname, profile: newProfile, status: newStatus, statusMessage: newStatusMessage)
                                                 newSenderFriend.append(newFriend)
                                             }
                                         }
                                         let newChat = Chat(uid: docId, sender: newSenderFriend[0], destination: newDestination, date: newDate, type: newType, body: newBody, raed: newRead, totalRead: newTotalRead)
                                         self.chat.append(newChat)
                                     }
                                 }
                             }
                         }
                     }
                 }
             }
         }
     }
     
     //need correction
     func readChat(userId: String, chatRoomId: String) {
         var totalUnreadChat:[String] = []
         
         self.db.collection(K.Chat.collectionName).whereField(K.Chat.destinationField, isEqualTo: chatRoomId).whereField(K.Chat.totalReadField, isEqualTo: false).getDocuments {(querySnapshot, error) in
             if let e = error {
                 print("There was an issue get data from Firestore. \(e)")
             } else {
                 if let snapshotDocuments = querySnapshot?.documents {
                     for doc in snapshotDocuments {
                         let docId = doc.documentID
                         totalUnreadChat.append(docId)
                     }
                 }
             }
         }
         
         if !totalUnreadChat.isEmpty {
             for chatId in totalUnreadChat {
                 let chatRef = self.db.collection(K.Chat.collectionName).document(chatId)
                 chatRef.updateData([K.Chat.readField: FieldValue.arrayRemove([userId])]) { error in
                     if let e = error {
                         print("There was an issue update data from Firestore. \(e)")
                     } else {
                         chatRef.getDocument {(documentSnapshot, error) in
                             if let e = error {
                                 print("There was an issue get data from Firestore. \(e)")
                             } else {
                                 if let document = documentSnapshot {
                                     if let data = document.data() {
                                         if let read = data[K.Chat.readField] as? [String] {
                                             if read.isEmpty {
                                                 chatRef.updateData([K.Chat.totalReadField: true])
                                             }
                                         }
                                     }
                                 }
                             }
                         }
                     }
                 }
             }
         }
         
         self.db.collection(K.ChatRoom.collectionName).document(chatRoomId).updateData(["%{K.ChatRoom.readField}.%{userId}": 0])
     }
     
     func addChat() {
         
     }
     func addMember() {
         
     }
     func deleteMember() {
         
     }
     /*
      func getDefaultTitle() -> String {
          var t = ""
          
          for n in memberNickname {
              t = t + n + ", "
          }
          
          t.removeLast(2)
          return t
      }
      */
 }


 */
