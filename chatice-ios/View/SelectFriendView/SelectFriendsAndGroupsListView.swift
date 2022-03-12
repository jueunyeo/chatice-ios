//
//  SelectFriendsAndGroupsListView.swift
//  chatice-ios
//
//  Created by admin on 3/3/22.
//

import SwiftUI

struct SelectFriendsAndGroupsListView: View {
    @ObservedObject var friendModel: FriendViewModel = FriendViewModel()
    @ObservedObject var friendGroupModel: FriendGroupViewModel = FriendGroupViewModel()
    
    @Binding var selectedFriends: [String]
    @Binding var selectedGroups: [String]
    
    @State private var selectedTab: Bool = true
    @State private var search: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal) {
                HStack {
                    if !(selectedFriends.isEmpty && selectedGroups.isEmpty) {
                        ForEach(0..<selectedFriends.count) { i in
                            if let f = friendModel.friend.first(where: {$0.uid == selectedFriends[i]}) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color(.systemGray5))
                                        .frame(height: 30)
                                    HStack {
                                        Text(f.nickname)
                                        Image(systemName: "xmark.circle")
                                            .foregroundColor(Color(.systemGray2))
                                            .onTapGesture {
                                                selectedFriends.remove(at: i)
                                            }
                                    }
                                    .padding()
                                }
                                .padding(5)
                            }
                        }
                        ForEach(0..<selectedGroups.count) { i in
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(.systemGray5))
                                    .frame(height: 30)
                                HStack {
                                    Text(selectedGroups[i])
                                    Image(systemName: "xmark.circle")
                                        .foregroundColor(Color(.systemGray2))
                                        .onTapGesture {
                                            selectedGroups.remove(at: i)
                                        }
                                }
                                .padding()
                            }
                            .padding(5)
                        }
                    }
                }
            }
            Divider()
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
            
            switch(selectedTab){
            case false:
                ScrollView {
                    VStack {
                        if !friendGroupModel.friendGroup.isEmpty {
                            ForEach(friendGroupModel.friendGroup.keys.sorted(), id: \.self) { key in
                                SelectGroupsCellView(selected: $selectedGroups, groupTitle: key)
                            }
                        }
                    }
                }.onAppear {
                    friendGroupModel.loadFriendGroup()
                }
                
            default:
                HStack {
                    ZStack{
                        TextField("검색", text: $search)
                            .font(Font.system(size: 14))
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 50).fill(Color(.systemGray5)))
                            .onTapGesture {
                                hideKeyboard()
                            }
                        if search.count > 0{
                            HStack {
                                Spacer()
                                Button(action: {
                                    search = ""
                                }) {
                                    Image(systemName: "xmark.circle")
                                        .foregroundColor(Color(.systemGray2))
                                        .padding(.horizontal)
                                }
                            }
                            
                        }
                    }
                    .padding(.horizontal)
                }
                
                ScrollView{
                    VStack(spacing: 0) {
                        HStack {
                            Text("팔로잉")
                                .foregroundColor(.gray)
                                .padding()
                            Spacer()
                        }
                        Divider()
                        
                        ForEach(0..<friendModel.friend.count) { i in
                            if search.count > 0 {
                                if friendModel.followingId.contains(friendModel.friend[i].uid) && friendModel.friend[i].nickname.contains(search) {
                                    SelectFriendsCellView(friendModel: friendModel, selected: $selectedFriends, cellNum: i)
                                    Divider()
                                }
                            } else {
                                if friendModel.followingId.contains(friendModel.friend[i].uid) {
                                    SelectFriendsCellView(friendModel: friendModel, selected: $selectedFriends, cellNum: i)
                                    Divider()
                                }
                            }
                        }
                        
                        HStack {
                            Text("연락처")
                                .foregroundColor(.gray)
                                .padding()
                            Spacer()
                        }
                        Divider()
                        
                        ForEach(0..<friendModel.friend.count) { i in
                            if search.count > 0 {
                                if !friendModel.followingId.contains(friendModel.friend[i].uid) && friendModel.friend[i].nickname.contains(search) {
                                    SelectFriendsCellView(friendModel: friendModel, selected: $selectedFriends, cellNum: i)
                                    Divider()
                                }
                            } else {
                                if !friendModel.followingId.contains(friendModel.friend[i].uid) {
                                    SelectFriendsCellView(friendModel: friendModel, selected: $selectedFriends, cellNum: i)
                                    Divider()
                                }
                            }
                        }
                    }
                }
                .onAppear {
                    friendModel.loadIdsAndFriend()
                }
            }
            Spacer()
        }
    }
}

