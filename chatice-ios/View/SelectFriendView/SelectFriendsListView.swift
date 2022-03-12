//
//  SelectFriendListView.swift
//  chatice-ios
//
//  Created by admin on 3/2/22.
//

import SwiftUI

struct SelectFriendsListView: View {
    @ObservedObject var friendModel: FriendViewModel = FriendViewModel()
    
    @Binding var selected: [String]
    
    @State private var search: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal) {
                HStack {
                    if !selected.isEmpty {
                        ForEach(0..<selected.count) { i in
                            if let f = friendModel.friend.first(where: {$0.uid == selected[i]}) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color(.systemGray5))
                                        .frame(height: 30)
                                    HStack {
                                        Text(f.nickname)
                                        Image(systemName: "xmark.circle")
                                            .foregroundColor(Color(.systemGray2))
                                            .onTapGesture {
                                                selected.remove(at: i)
                                            }
                                    }
                                    .padding()
                                }
                                .padding(5)
                            }
                        }
                    }
                }
            }
            Divider()
            
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
                                SelectFriendsCellView(friendModel: friendModel, selected: $selected, cellNum: i)
                                Divider()
                            }
                        } else {
                            if friendModel.followingId.contains(friendModel.friend[i].uid) {
                                SelectFriendsCellView(friendModel: friendModel, selected: $selected, cellNum: i)
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
                                SelectFriendsCellView(friendModel: friendModel, selected: $selected, cellNum: i)
                                Divider()
                            }
                        } else {
                            if !friendModel.followingId.contains(friendModel.friend[i].uid) {
                                SelectFriendsCellView(friendModel: friendModel, selected: $selected, cellNum: i)
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
    }
}


