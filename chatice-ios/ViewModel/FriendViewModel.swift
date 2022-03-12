//
//  FriendViewModel.swift
//  chatice-ios
//
//  Created by admin on 2/28/22.
//

import Foundation
import Firebase
import SwiftUI

struct Friend {
    let uid: String
    let phoneNumber: String
    let nickname: String
    let profileExist: Bool
    let status: Bool
    let statusMessage: String
    let profileImage: UIImage
}

class FriendViewModel: ObservableObject {
    @Published var friend: [Friend] = []
    @Published var followingId: [String] = []
    @Published var followerId: [String] = []
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    func addFriendWhenLaunch() {
        
    }
    
    func loadIdsAndFriend() {
        self.followingId = []
        self.followerId = []
        if let user = Auth.auth().currentUser {
            let userUid = user.uid
            self.db.collection(K.UserInfo.collectionName).document(userUid).getDocument { (documentSnapshot, error) in
                if let e = error {
                    print("There was an issue get data from Firestore. \(e)")
                } else {
                    if let document = documentSnapshot {
                        if let data = document.data() {
                            if let followingId = data[K.UserInfo.followingField] as? [String],
                               let followerId = data[K.UserInfo.followerField] as? [String] {
                                self.followingId = followingId
                                self.followerId = followerId
                                self.loadFriend()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func loadFriend() {
        var friendLoad: [Friend] = []
        if let user = Auth.auth().currentUser {
            let userUid = user.uid
            self.db.collection(K.UserInfo.collectionName).document(userUid).getDocument { (documentSnapshot, error) in
                if let e = error {
                    print("There was an issue get data from Firestore. \(e)")
                } else {
                    if let document = documentSnapshot {
                        if let data = document.data() {
                            if let friendId = data[K.UserInfo.friendField] as? [String] {
                                self.db.collection(K.UserInfo.collectionName).getDocuments {(querySnapshot, error) in
                                    if let snapshotDocuments = querySnapshot?.documents {
                                        for doc in snapshotDocuments {
                                            if friendId.contains(doc.documentID) {
                                                let data = doc.data()
                                                if let newPhoneNumber = data[K.UserInfo.phoneNumberField] as? String,
                                                   let newNickname = data[K.UserInfo.nicknameField] as? String,
                                                   let newProfileExist = data[K.UserInfo.profileExistField] as? Bool,
                                                   let newStatus = data[K.UserInfo.statusField] as? Bool,
                                                   let newStatusMessage = data[K.UserInfo.statusMessageField] as? String {
                                                    if newProfileExist {
                                                        let profileRef = self.storage.reference().child("/userProfileImages/\(doc.documentID).jpg")
                                                        profileRef.getData(maxSize: 1 * 1024 * 1024) {(data, error) in
                                                            if let e = error {
                                                                print("There was an issue get data from Storage. \(e)")
                                                                let newFriend = Friend(uid: doc.documentID, phoneNumber: newPhoneNumber, nickname: newNickname, profileExist: newProfileExist, status: newStatus, statusMessage: newStatusMessage, profileImage: UIImage(named: "defaultProfile")!)
                                                                friendLoad.append(newFriend)
                                                            } else {
                                                                if let d = data {
                                                                    if let getImage = UIImage(data: d) {
                                                                        let newFriend = Friend(uid: doc.documentID, phoneNumber: newPhoneNumber, nickname: newNickname, profileExist: newProfileExist, status: newStatus, statusMessage: newStatusMessage, profileImage: getImage)
                                                                        friendLoad.append(newFriend)
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    } else {
                                                        let newFriend = Friend(uid: doc.documentID, phoneNumber: newPhoneNumber, nickname: newNickname, profileExist: newProfileExist, status: newStatus, statusMessage: newStatusMessage, profileImage: UIImage(named: "defaultProfile")!)
                                                        friendLoad.append(newFriend)
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
            }
        }
        self.friend = friendLoad
    }
    
    func addAndLoadFriend() {
        
    }
    
    
    func sendFollowing() {
        
    }
    
    func deleteAndLoadFollowing(friendId: String) {
        if let user = Auth.auth().currentUser {
            let userUid = user.uid
            let userRef = self.db.collection(K.UserInfo.collectionName).document(userUid)
            userRef.updateData([K.UserInfo.followingField: FieldValue.arrayRemove([friendId])]) { error in
                if let e = error {
                    print("There was an issue update data from Firestore. \(e)")
                } else {
                    self.loadFriend()
                }
            }
        }
        
    }
    
    func acceptAndLoadFollower() {
        
    }
    
    func deleteAndLoadFollower() {
        
    }
    
}


