//
//  MyCellView.swift
//  chatice-ios
//
//  Created by admin on 2/23/22.
//

import SwiftUI

struct MyContactCellView: View {
    @ObservedObject var userModel: UserProfileViewModel
    @Binding var openChangeStatusMessage: Bool
    @State private var tapped: Bool = false
    
    
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
                    if !userModel.profileExist {
                        Image("defaultProfile")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 40.0, height: 40.0)
                            
                    } else {
                        Image(uiImage: userModel.profileImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 40.0, height: 40.0)
                    }
                    
                    Text(userModel.nickname)
                        .padding(.horizontal)
                        .font(.system(size: 18))
                        .lineLimit(1)
                    Spacer()
                    if userModel.status {
                        Circle()
                            .frame(width:10.0, height: 10.0)
                            .foregroundColor(.red)
                    } else {
                        Circle()
                            .frame(width:10.0, height: 10.0)
                            .foregroundColor(.clear)
                    }
                    
                    Text(userModel.statusMessage)
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
                            Image(systemName: "figure.walk")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20.0, height: 20.0)
                            Text("현재")
                                .font(.system(size: 11))
                            Text("상태")
                                .font(.system(size: 11))
                        }
                        .padding()
                        .onTapGesture {
                            openChangeStatusMessage = true
                        }
                        
                        
                        VStack {
                            if userModel.status {
                                Image(systemName: "hand.raised.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20.0, height: 20.0)
                                    .foregroundColor(.red)
                            } else {
                                Image(systemName: "hand.raised.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20.0, height: 20.0)
                                    .foregroundColor(.gray)
                            }
                            Text("답장")
                                .font(.system(size: 11))
                            Text("불가")
                                .font(.system(size: 11))
                        }
                        .padding()
                        .onTapGesture {
                            userModel.changeAndLoadStatus()
                        }
                        
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
                        .onTapGesture {
                            
                        }
                        
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
                        .onTapGesture {
                            
                        }
                    }
                }
            }
        }
    }
}

