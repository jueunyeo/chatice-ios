//
//  AuthViewModel.swift
//  chatice-ios
//
//  Created by admin on 3/4/22.
//

import Foundation
import Firebase

class AuthViewModel: ObservableObject {
    //@Published var isAuth: Bool = false
    @Published var isCodeSent: Bool = false
    @Published var isVerified: Bool = false
    @Published var isRegistered: Bool = false
    @Published var userUid: String = ""
    @Published var userPhoneNumber: String = ""
    @Published var userNickname: String = ""
    
    let authRef = Auth.auth()
    let db = Firestore.firestore()
    
    func sendCode (phoneNumber: String) {
        authRef.languageCode = "kr"
        PhoneAuthProvider.provider(auth: authRef).verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
            if let e = error {
                print("There was an issue sending code. \(e)")
            } else {
                if let verifId = verificationID {
                    UserDefaults.standard.set(verifId, forKey: "authVerificationID")
                    self.isCodeSent = true
                    self.userPhoneNumber = phoneNumber
                }
            }
        }
    }
    
    func verifyCode (code:String) {
        if let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") {
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: code)
            authRef.signIn(with: credential) { (authResult, error) in
                if let e = error {
                    print("There was an issue verifying code. \(e)")
                } else {
                    if let result = authResult {
                        self.userUid = result.user.uid
                        self.db.collection(K.UserInfo.collectionName).document(self.userUid).getDocument {(documentSnapshot, error) in
                            if let e = error {
                                print("There was an issue get data from Firestore. \(e)")
                            } else {
                                if let document = documentSnapshot {
                                    if document.exists {
                                        //existing user
                                        if let data = document.data() {
                                            if let nickname = data[K.UserInfo.nicknameField] as? String {
                                                self.userNickname = nickname
                                                self.isVerified = true
                                                self.isRegistered = true
                                            }
                                        }
                                    } else {
                                        //new user
                                        self.isVerified = true
                                        self.isRegistered = false
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func createUserInfo(newNickname: String) {
        self.userNickname = newNickname
        if self.userUid.count > 0 && self.userPhoneNumber.count > 0 {
            let newUserData: [String: Any] = [
                K.UserInfo.phoneNumberField: self.userPhoneNumber,
                K.UserInfo.nicknameField: self.userNickname,
                K.UserInfo.profileExistField: false,
                K.UserInfo.statusField: false,
                K.UserInfo.statusMessageField: "",
                K.UserInfo.friendField: [],
                K.UserInfo.followingField: [],
                K.UserInfo.followerField: [],
                K.UserInfo.friendGroupField: []
            ]
            self.db.collection(K.UserInfo.collectionName).document(self.userUid).setData(newUserData) { error in
                if let e = error {
                    print("There was an issue get data from Firestore. \(e)")
                } else {
                    self.isRegistered = true
                }
            }
        } else {
            print("no userUid, no userPhonenumber.")
        }
    }
    
    
}


