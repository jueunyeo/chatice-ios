//
//  NotFollowingCellView.swift
//  chatice-ios
//
//  Created by admin on 2/23/22.
//

import SwiftUI

struct NotFollowingCellView: View {
    @ObservedObject var friendModel: FriendViewModel
    
    let cellNum: Int
    
    @State private var tapped: Bool = false
    @State private var showingFollowAlert = false
    
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
                            showingFollowAlert = true
                        }) {
                            VStack{
                                Image(systemName: "person.fill.checkmark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20.0, height: 20.0)
                                Text("팔로우 ")
                                    .font(.system(size: 11))
                            }
                            .padding()
                            .alert("팔로우 신청하시겠습니까?", isPresented: $showingFollowAlert) {
                                Button("팔로우 신청", role: .destructive, action: {
                                    //follow logic
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

