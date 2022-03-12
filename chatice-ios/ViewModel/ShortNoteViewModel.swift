//
//  ShortNoteViewModel.swift
//  chatice-ios
//
//  Created by admin on 3/6/22.
//

import Foundation
import Firebase
import UserNotifications

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
    @Published var listener: ListenerRegistration?
    
    
    let db = Firestore.firestore()
    let storage = Storage.storage()
    
    func loadAndNotifyInShortNote(userId: String) {
        var getShortNote:[ShortNote] = []
        if let user = Auth.auth().currentUser {
            let userUid = user.uid
            listener = self.db.collection(K.ShortNote.collectionName).whereField(K.ShortNote.destinationField, arrayContains: userUid).addSnapshotListener {(querySnapshot, error) in
                if let e = error {
                    print("There was an issue get data from Firestore. \(e)")
                } else {
                    if let snapshot = querySnapshot?.documents {
                        for doc in snapshot {
                            let data = doc.data()
                            if let newSender = data[K.ShortNote.senderField] as? String,
                               let newDestination = data[K.ShortNote.destinationField] as? [String],
                               let newDate = data[K.ShortNote.dateField] as? Date,
                               let newTextBody = data[K.ShortNote.textBodyField] as? String,
                               let newRead = data[K.ShortNote.readField] as? Bool,
                               let newLike = data[K.ShortNote.likeField] as? Bool {
                                let newShortNote = ShortNote(uid: doc.documentID, sender: newSender, destination: newDestination, date: newDate, textBody: newTextBody, read: newRead, like: newLike)
                                getShortNote.append(newShortNote)
                                
                            }
                        }
                    }
                }
            }
        }
        
    }
}
