//
//  MyAlert.swift
//  chatice-ios
//
//  Created by admin on 3/2/22.
//

import SwiftUI
//stackoverflow.com/questions/56726663/how-to-add-a-textfield-to-alert-in-swiftui

struct CreateGroupTextAlert: View {
    @Binding var openCreateGroup: Bool
    let groupMembers: [String]
    @State private var newGroupTitle: String = ""
    
    var body: some View {
        VStack {
            Text("그룹 이름").font(.headline).padding()
            
            TextField("", text: $newGroupTitle).textFieldStyle(RoundedBorderTextFieldStyle()).padding()
            Divider()
            HStack {
                Spacer()
                
                Button(action: {
                    UIApplication.shared.windows[0].rootViewController?.dismiss(animated: true, completion: {})
                }) {
                    Text("닫기")
                }
                
                Spacer()

                Divider()

                Spacer()
                
                Button(action: {
                    //userModel.addFriendGroup(groupTitle: newGroupTitle, groupMembers: groupMembers)
                    UIApplication.shared.windows[0].rootViewController?.dismiss(animated: true, completion: {})
                    openCreateGroup = false
                }) {
                    Text("만들기")
                }
                .disabled(newGroupTitle.count == 0)
                
                Spacer()
            }
            .padding(0)
        }
        .background(Color(white: 0.9))
    }
}



