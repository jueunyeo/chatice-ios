//
//  SelectFriendCellView.swift
//  chatice-ios
//
//  Created by admin on 3/2/22.
//

import SwiftUI

struct SelectFriendCellView: View {
    @ObservedObject var friendModel: FriendViewModel
    
    @Binding var selected: String
    let cellNum: Int
    
    var body: some View {
        VStack(spacing: 0) {
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
                Spacer()
                Image(systemName: selected == friendModel.friend[cellNum].uid ? "smallcircle.filled.circle.fill" : "circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25.0, height: 25.0)
                    .foregroundColor(selected == friendModel.friend[cellNum].uid ? Color(.systemBlue) : Color.secondary)
                    .onTapGesture {
                        if selected == friendModel.friend[cellNum].uid {
                            selected = ""
                        } else {
                            selected = friendModel.friend[cellNum].uid
                        }
                    }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}


