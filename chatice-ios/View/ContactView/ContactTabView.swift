//
//  ContactTabView.swift
//  chatice-ios
//
//  Created by admin on 2/21/22.
//

import SwiftUI

struct ContactTabView: View {    
    @State private var selectedTab: Bool = true
    @State private var openInviteContact: Bool = false
    @State private var openCreateGroup: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0){
                HStack(spacing: 0) {
                    VStack {
                        Text("친구")
                            .font(.system(size: 17, weight: selectedTab ? .bold : .regular))
                            .foregroundColor(selectedTab ? Color(.black) : Color.secondary)
                        Divider()
                            .background(selectedTab ? Color(.black) : Color.secondary)
                    }
                    .onTapGesture {
                        selectedTab = true
                    }
                    
                    VStack {
                        Text("그룹")
                            .font(.system(size: 17, weight: selectedTab ? .regular : .bold))
                            .foregroundColor(selectedTab ? Color.secondary : Color(.black))
                        Divider()
                            .background(selectedTab ? Color.secondary : Color(.black))
                    }
                    .onTapGesture {
                        selectedTab = false
                    }
                    
                }
                /*
                 switch(selectedTab) {
                 case false: GroupListView(userModel: userModel)
                         .sheet(isPresented: $openCreateGroup) {
                             CreateGroupView(userModel: userModel, openCreateGroup: $openCreateGroup)
                         }
                 default: FriendListView(userModel: userModel)
                         .sheet(isPresented: $openInviteContact) {
                             //InviteContactView(openInviteContact: $openInviteContact)
                         }
                 }
                 */
                
                
                Spacer()
            }
            .navigationTitle("친구")
            .navigationBarItems(trailing: selectedTab ? Button(action: {
                openInviteContact = true
            }) {
                Image(systemName: "plus")
                    .imageScale(.large)
            } : Button(action: {
                openCreateGroup = true
            }) {
                Image(systemName: "plus")
                    .imageScale(.large)
            })
        }
    }
}

