//
//  FriendListView.swift
//  chatice-ios
//
//  Created by admin on 2/21/22.
//

import SwiftUI
import SlideOverCard

struct FriendListView: View {
    @ObservedObject var userModel: UserProfileViewModel = UserProfileViewModel()
    @ObservedObject var friendModel: FriendViewModel = FriendViewModel()
    
    @State private var search: String = ""
    @State var openChangeStatusMessage: Bool = false
    
    var body: some View {
        ZStack {
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
                        MyContactCellView(userModel: self.userModel, openChangeStatusMessage: $openChangeStatusMessage)
                            
                        Divider()
                        
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
                                    FollowingCellView(friendModel: friendModel, cellNum: i)
                                    Divider()
                                }
                            } else {
                                if friendModel.followingId.contains(friendModel.friend[i].uid) {
                                    FollowingCellView(friendModel: friendModel, cellNum: i)
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
                        
                        if !friendModel.friend.isEmpty {
                            ForEach(0..<friendModel.friend.count) { i in
                                if search.count > 0 {
                                    if !friendModel.followingId.contains(friendModel.friend[i].uid) && friendModel.friend[i].nickname.contains(search) {
                                        NotFollowingCellView(friendModel: friendModel, cellNum: i)
                                        Divider()
                                    }
                                } else {
                                    if !friendModel.followingId.contains(friendModel.friend[i].uid) {
                                        NotFollowingCellView(friendModel: friendModel, cellNum: i)
                                        Divider()
                                    }
                                }
                            }
                        }
                    }
                }
                .onAppear {
                    userModel.loadUserProfile()
                    friendModel.loadIdsAndFriend()
                }
            }
            
            SlideOverCard(isPresented: $openChangeStatusMessage) {
                ChangeStatusMessageView(userModel: userModel, openChangeStatusMessage: $openChangeStatusMessage)
            }
            
        }
    }
}
