//
//  ShortNoteViewModel.swift
//  chatice-ios
//
//  Created by admin on 2/21/22.
//

import Foundation
import Firebase
/*
struct ShortNote {
    let uid: String
    let sender: Friend
    let destination: [Friend]
    let date: Date
    let textBody: String
    //let imageBody: String
    var read: Bool
    var like: Bool
}
class InShortNoteViewModel: ObservableObject {
    @Published var inShortNote: [ShortNote] = []
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    func loadShortNote(userId: String) {
        
    }
}

 class InShortNoteViewModel: ObservableObject {
     @Published var inShortNote: [ShortNote] = []
     
     let db = Firestore.firestore()
     let storage = Storage.storage()
     
     func loadShortNote(userId: String) {
         self.db.collection(K.ShortNote.collectionName).whereField(K.ShortNote.destinationField, arrayContains: userId).order(by: K.ShortNote.dateField).addSnapshotListener {(querySnapshot, error) in
             self.inShortNote = []
             if let e = error {
                 print("There was an issue get data from Firestore. \(e)")
             } else {
                 if let snapshotDocuments = querySnapshot?.documents {
                     for doc in snapshotDocuments {
                         let newUid = doc.documentID
                         let data = doc.data()
                         if let newSender = data[K.ShortNote.senderField] as? String,
                            let newDestination = data[K.ShortNote.destinationField] as? [String],
                            let newDate = data[K.ShortNote.dateField] as? Date,
                            let newTextBody = data[K.ShortNote.textBodyField] as? String,
                            let newRead = data[K.ShortNote.readField] as? Bool,
                            let newLike = data[K.ShortNote.likeField] as? Bool {
                             self.db.collection(K.UserInfo.collectionName).getDocuments { (querySnapshot, error) in
                                 var newSenderFriend: [Friend] = []
                                 var newDestinationFriend: [Friend] = []
                                 if let e = error {
                                     print("There was an issue get data from Firestore. \(e)")
                                 } else {
                                     if let snapshotDocuments = querySnapshot?.documents {
                                         for doc in snapshotDocuments {
                                             let docId = doc.documentID
                                             if newSender.contains(docId) {
                                                 let newUid = doc.documentID
                                                 let data = doc.data()
                                                 if let newPhoneNumber = data[K.UserInfo.phoneNumberField] as? String,
                                                    let newNickname = data[K.UserInfo.nicknameField] as? String,
                                                    let newProfile = data[K.UserInfo.profileField] as? String,
                                                    let newStatus = data[K.UserInfo.statusField] as? Bool,
                                                    let newStatusMessage = data[K.UserInfo.statusMessageField] as? String {
                                                     let newFriend = Friend(uid: newUid, phoneNumber: newPhoneNumber, nickname: newNickname, profile: newProfile, status: newStatus, statusMessage: newStatusMessage)
                                                     newSenderFriend.append(newFriend)
                                                 }
                                             } else if newDestination.contains(docId) {
                                                 let newUid = doc.documentID
                                                 let data = doc.data()
                                                 if let newPhoneNumber = data[K.UserInfo.phoneNumberField] as? String,
                                                    let newNickname = data[K.UserInfo.nicknameField] as? String,
                                                    let newProfile = data[K.UserInfo.profileField] as? String,
                                                    let newStatus = data[K.UserInfo.statusField] as? Bool,
                                                    let newStatusMessage = data[K.UserInfo.statusMessageField] as? String {
                                                     let newFriend = Friend(uid: newUid, phoneNumber: newPhoneNumber, nickname: newNickname, profile: newProfile, status: newStatus, statusMessage: newStatusMessage)
                                                     newDestinationFriend.append(newFriend)
                                                 }
                                             }
                                         }
                                         let newShortNote = ShortNote(uid: newUid, sender: newSenderFriend[0], destination: newDestinationFriend, date: newDate, textBody: newTextBody, read: newRead, like: newLike)
                                         self.inShortNote.append(newShortNote)
                                     }
                                 }
                             }
                         }
                     }
                 }
             }
         }
     }
     
     func makeRead() {
         
     }
     
     func makeLike() {
         
     }
     
     func makeUnlike() {
         
     }
 }


 */
