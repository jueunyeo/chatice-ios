//
//  FriendGroupViewModel.swift
//  chatice-ios
//
//  Created by admin on 2/28/22.
//

import Foundation
import Firebase
import SwiftUI


class FriendGroupViewModel: ObservableObject {
    @Published var friendGroup: [String:[Friend]] = [:]
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    func loadFriendGroup() {
        var friendGroupLoad: [String:[Friend]] = [:]
        if let user = Auth.auth().currentUser {
            let userUid = user.uid
            self.db.collection(K.UserInfo.collectionName).document(userUid).getDocument { (documentSnapshot, error) in
                if let e = error {
                    print("There was an issue get data from Firestore. \(e)")
                } else {
                    if let document = documentSnapshot {
                        if let data = document.data() {
                            if let getFriendGroup = data[K.UserInfo.friendGroupField] as? [String:[String]] {
                                for (title, memberIds) in getFriendGroup {
                                    let groupTitle = title
                                    var groupMembers:[Friend] = []
                                    for memberId in memberIds {
                                        self.db.collection(K.UserInfo.collectionName).document(memberId).getDocument {(documentSnapshot, error) in
                                            if let e = error {
                                                print("There was an issue get data from Firestore. \(e)")
                                            } else {
                                                if let document = documentSnapshot {
                                                    if let data = document.data() {
                                                        if let newPhoneNumber = data[K.UserInfo.phoneNumberField] as? String,
                                                           let newNickname = data[K.UserInfo.nicknameField] as? String,
                                                           let newProfileExist = data[K.UserInfo.profileExistField] as? Bool,
                                                           let newStatus = data[K.UserInfo.statusField] as? Bool,
                                                           let newStatusMessage = data[K.UserInfo.statusMessageField] as? String {
                                                            if newProfileExist {
                                                                let profileRef = self.storage.reference().child("/userProfileImages/\(memberId).jpg")
                                                                profileRef.getData(maxSize: 1 * 1024 * 1024) {(data, error) in
                                                                    if let e = error {
                                                                        print("There was an issue get data from Storage. \(e)")
                                                                        let newFriend = Friend(uid: memberId, phoneNumber: newPhoneNumber, nickname: newNickname, profileExist: newProfileExist, status: newStatus, statusMessage: newStatusMessage, profileImage: UIImage(named: "defaultProfile")!)
                                                                        groupMembers.append(newFriend)
                                                                    } else {
                                                                        if let d = data {
                                                                            if let getImage = UIImage(data: d) {
                                                                                let newFriend = Friend(uid: memberId, phoneNumber: newPhoneNumber, nickname: newNickname, profileExist: newProfileExist, status: newStatus, statusMessage: newStatusMessage, profileImage: getImage)
                                                                                groupMembers.append(newFriend)
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            } else {
                                                                let newFriend = Friend(uid: memberId, phoneNumber: newPhoneNumber, nickname: newNickname, profileExist: newProfileExist, status: newStatus, statusMessage: newStatusMessage, profileImage: UIImage(named: "defaultProfile")!)
                                                                groupMembers.append(newFriend)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    friendGroupLoad[groupTitle] = groupMembers
                                }
                            }
                        }
                    }
                }
            }
        }
        self.friendGroup = friendGroupLoad
    }
    
    func addAndLoadGroup(newTitle: String, newMembers: [String]){
        if let user = Auth.auth().currentUser {
            let userUid = user.uid
            let userRef = self.db.collection(K.UserInfo.collectionName).document(userUid)
            //seriously need test for db structure
            userRef.updateData([K.UserInfo.friendGroupField: FieldValue.arrayUnion([[newTitle:newMembers]])]) { error in
                if let e = error {
                    print("There was an issue update data from Firestore. \(e)")
                } else {
                    self.loadFriendGroup()
                }
            }
        }
    }
    
    func deleteAndLoadGroup(groupTitle: String) {
        if let user = Auth.auth().currentUser {
            let userUid = user.uid
            self.db.collection(K.UserInfo.collectionName).document(userUid).getDocument { (documentSnapshot, error) in
                if let e = error {
                    print("There was an issue get data from Firestore. \(e)")
                } else {
                    if let document = documentSnapshot {
                        if let data = document.data() {
                            if var currentFriendGroup = data[K.UserInfo.friendGroupField] as? [String:[String]]{
                                currentFriendGroup[groupTitle] = nil
                                let newFriendGroup = currentFriendGroup
                                self.db.collection(K.UserInfo.collectionName).document(userUid).updateData([K.UserInfo.friendGroupField: newFriendGroup]) { error in
                                    if let e = error {
                                        print("There was an issue update data from Firestore. \(e)")
                                    } else {
                                        self.loadFriendGroup()
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

