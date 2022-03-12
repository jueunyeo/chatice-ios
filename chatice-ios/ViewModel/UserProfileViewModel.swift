//
//  UserProfileViewModel.swift
//  chatice-ios
//
//  Created by admin on 3/5/22.
//

import Foundation
import Firebase
import SwiftUI

class UserProfileViewModel: ObservableObject {
    @Published var phoneNumber: String = ""
    @Published var nickname: String = ""
    @Published var profileExist: Bool = false
    @Published var status: Bool = false
    @Published var statusMessage: String = ""
    @Published var profileImage: UIImage = UIImage(named: "defaultProfile")!
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    func loadUserProfile() {
        if let user = Auth.auth().currentUser {
            let userUid = user.uid
            self.db.collection(K.UserInfo.collectionName).document(userUid).getDocument { (documentSnapshot, error) in
                if let e = error {
                    print("There was an issue get data from Firestore. \(e)")
                } else {
                    if let document = documentSnapshot {
                        if let data = document.data() {
                            if let phoneNumberData = data[K.UserInfo.phoneNumberField] as? String,
                               let nicknameData = data[K.UserInfo.nicknameField] as? String,
                               let profileExistData = data[K.UserInfo.profileExistField] as? Bool,
                               let statusData = data[K.UserInfo.statusField] as? Bool,
                               let statusMessageData = data[K.UserInfo.statusMessageField] as? String {
                                if profileExistData {
                                    let profileRef = self.storage.reference().child("/userProfileImages/\(userUid).jpg")
                                    profileRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                                        if let e = error {
                                            print("There was an issue get data from Storage. \(e)")
                                            self.phoneNumber = phoneNumberData
                                            self.nickname = nicknameData
                                            self.profileExist = profileExistData
                                            self.status = statusData
                                            self.statusMessage = statusMessageData
                                            self.profileImage = UIImage(named: "defaultProfile")!
                                        } else {
                                            if let d = data {
                                                if let getImage = UIImage(data: d) {
                                                    self.phoneNumber = phoneNumberData
                                                    self.nickname = nicknameData
                                                    self.profileExist = profileExistData
                                                    self.status = statusData
                                                    self.statusMessage = statusMessageData
                                                    self.profileImage = getImage
                                                }
                                            }
                                        }
                                    }
                                } else {
                                    self.phoneNumber = phoneNumberData
                                    self.nickname = nicknameData
                                    self.profileExist = profileExistData
                                    self.status = statusData
                                    self.statusMessage = statusMessageData
                                    self.profileImage = UIImage(named: "defaultProfile")!
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    /*
     func loadUserProfileImage() {
         if let user = Auth.auth().currentUser {
             let userUid = user.uid
             let profileRef = self.storage.reference().child("/userProfileImages/\(userUid).jpg")
             profileRef.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                 if let e = error {
                     print("There was an issue get data from Storage. \(e)")
                 } else {
                     if let d = data {
                         if let getImage = UIImage(data: d) {
                             self.profileImage = getImage
                         }
                     }
                 }
             }
         }
     }
     */
    
    
    func changeAndLoadNickname(newNickname: String) {
        if let user = Auth.auth().currentUser {
            let userUid = user.uid
            let userRef = self.db.collection(K.UserInfo.collectionName).document(userUid)
            userRef.updateData([K.UserInfo.nicknameField: newNickname]) { error in
                if let e = error {
                    print("There was an issue update data from Firestore. \(e)")
                } else {
                    userRef.getDocument {(documentSnapshot, error) in
                        if let e = error {
                            print("There was an issue get data from Firestore. \(e)")
                        } else {
                            if let document = documentSnapshot {
                                if let data = document.data() {
                                    if let getNewNickname = data[K.UserInfo.nicknameField] as? String {
                                        self.nickname = getNewNickname
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func changeAndLoadProfileImage() {
        
    }
    
    func changeAndLoadStatus() {
        if let user = Auth.auth().currentUser {
            let userUid = user.uid
            let userRef = self.db.collection(K.UserInfo.collectionName).document(userUid)
            
            if self.status {
                userRef.updateData([K.UserInfo.statusField: false]) { error in
                    if let e = error {
                        print("There was an issue update data from Firestore. \(e)")
                    } else {
                        userRef.getDocument {(documentSnapshot, error) in
                            if let e = error {
                                print("There was an issue get data from Firestore. \(e)")
                            } else {
                                if let document = documentSnapshot {
                                    if let data = document.data() {
                                        if let newStatus = data[K.UserInfo.statusField] as? Bool {
                                            self.status = newStatus
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            } else {
                userRef.updateData([K.UserInfo.statusField: true]) {error in
                    if let e = error {
                        print("There was an issue update data from Firestore. \(e)")
                    } else {
                        userRef.getDocument {(documentSnapshot, error) in
                            if let e = error {
                                print("There was an issue get data from Firestore. \(e)")
                            } else {
                                if let document = documentSnapshot {
                                    if let data = document.data() {
                                        if let newStatus = data[K.UserInfo.statusField] as? Bool {
                                            self.status = newStatus
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
    
    func changeAndLoadStatusMessage(selectedStatusMessage: String) {
        if let user = Auth.auth().currentUser {
            let userUid = user.uid
            let userRef = self.db.collection(K.UserInfo.collectionName).document(userUid)
            userRef.updateData([K.UserInfo.statusMessageField: selectedStatusMessage]) {error in
                if let e = error {
                    print("There was an issue update data from Firestore. \(e)")
                } else {
                    userRef.getDocument {(documentSnapshot, error) in
                        if let e = error {
                            print("There was an issue get data from Firestore. \(e)")
                        } else {
                            if let document = documentSnapshot {
                                if let data = document.data() {
                                    if let newStatusMessage = data[K.UserInfo.statusMessageField] as? String {
                                        self.statusMessage = newStatusMessage
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
