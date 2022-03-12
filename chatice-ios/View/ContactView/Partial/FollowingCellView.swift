//
//  FriendCellView.swift
//  chatice-ios
//
//  Created by admin on 2/21/22.
//

import SwiftUI

struct FollowingCellView: View {
    @ObservedObject var friendModel: FriendViewModel
    
    let cellNum: Int
    
    @State private var tapped: Bool = false
    @State private var showingUnfollowAlert = false
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Color(.white)
                    .onTapGesture(perform: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            tapped.toggle()
                        }
                    })
                HStack {
                    if !friendModel.friend[cellNum].profileExist {
                        Image("defaultProfile")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 40.0, height: 40.0)
                    } else {
                        Image(uiImage: friendModel.friend[cellNum].profileImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 40.0, height: 40.0)
                    }
                    
                    Text(friendModel.friend[cellNum].nickname)
                        .padding(.horizontal)
                        .font(.system(size: 18))
                        .lineLimit(1)
                    Spacer()
                    if friendModel.friend[cellNum].status {
                        Circle()
                            .frame(width:10.0, height: 10.0)
                            .foregroundColor(.red)
                    } else {
                        Circle()
                            .frame(width:10.0, height: 10.0)
                            .foregroundColor(.clear)
                    }
                    
                    Text(friendModel.friend[cellNum].statusMessage)
                        .foregroundColor(.gray)
                    
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
                 
            
            if tapped {
                ZStack{
                    Color(.systemGray5)
                    HStack {
                        VStack {
                            Image(systemName: "bubble.left.and.bubble.right.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20.0, height: 20.0)
                            Text("1:1")
                                .font(.system(size: 11))
                            Text("채팅")
                                .font(.system(size: 11))
                        }
                        .padding()
                        
                        Rectangle()
                            .frame(width: 18.0, height: 18.0)
                            .foregroundColor(Color(.systemGray5))
                        
                        VStack{
                            Image(systemName: "list.bullet")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20.0, height: 20.0)
                            Text("숏노트로")
                                .font(.system(size: 11))
                            Text("보내기")
                                .font(.system(size: 11))
                        }
                        .padding()
                        
                        Rectangle()
                            .frame(width: 18.0, height: 18.0)
                            .foregroundColor(Color(.systemGray5))
                        
                        Button(action: {
                            showingUnfollowAlert = true
                        }) {
                            VStack{
                                Image(systemName: "person.fill.xmark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20.0, height: 20.0)
                                Text("팔로우")
                                    .font(.system(size: 11))
                                Text("취소")
                                    .font(.system(size: 11))
                            }
                            .padding()
                            .alert("팔로우 취소하시겠습니까?", isPresented: $showingUnfollowAlert) {
                                Button("팔로우 취소", role: .destructive, action: {
                                    //friendModel.deleteFollowing()
                                })
                                Button("닫기", role: .cancel, action: {})
                            }
                        }
                        
                    }
                }
            }
        }
    }
}

