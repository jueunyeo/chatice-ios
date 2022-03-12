//
//  SelectFriendListView.swift
//  chatice-ios
//
//  Created by admin on 3/2/22.
//

import SwiftUI

struct SelectFriendListView: View {
    @ObservedObject var friendModel: FriendViewModel = FriendViewModel()
    
    @Binding var selected: String
    
    @State private var search: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
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
                                SelectFriendCellView(friendModel: friendModel, selected: $selected, cellNum: i)
                                Divider()
                            }
                        } else {
                            if friendModel.followingId.contains(friendModel.friend[i].uid) {
                                SelectFriendCellView(friendModel: friendModel, selected: $selected, cellNum: i)
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
                                SelectFriendCellView(friendModel: friendModel, selected: $selected, cellNum: i)
                                Divider()
                            }
                        } else {
                            if !friendModel.followingId.contains(friendModel.friend[i].uid) {
                                SelectFriendCellView(friendModel: friendModel, selected: $selected, cellNum: i)
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


