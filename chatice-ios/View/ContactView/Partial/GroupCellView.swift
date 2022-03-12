//
//  GroupCellView.swift
//  chatice-ios
//
//  Created by admin on 2/21/22.
//

import SwiftUI


 struct GroupCellView: View {
     @ObservedObject var friendGroupModel: FriendGroupViewModel
     let groupTitle: String
     
     @State private var tapped: Bool = false
     @State private var showingDeleteAlert = false
     
     var body: some View {
         if let thisGroup = friendGroupModel.friendGroup[groupTitle] {
             VStack(spacing: 0) {
                 ZStack {
                     Color(.systemGray5)
                         .onTapGesture(perform: {
                             withAnimation(.easeInOut(duration: 0.2)) {
                                 tapped.toggle()
                             }
                         })
                     HStack {
                         Text("\(groupTitle) (\(thisGroup.count))")
                             .padding(.horizontal)
                             .font(.system(size: 18))
                             .lineLimit(1)
                         Spacer()
                         
                         Button(action: {
                             showingDeleteAlert.toggle()
                         }) {
                             Text("삭제")
                                 .foregroundColor(.red)
                                 .padding(.horizontal)
                             
                             .alert("삭제하시겠습니까?", isPresented: $showingDeleteAlert) {
                                 Button("삭제", role: .destructive, action: {
                                     friendGroupModel.deleteAndLoadGroup(groupTitle: groupTitle)
                                 })
                                 Button("닫기", role: .cancel, action: {})
                             }
                         }
                     }
                     .padding()
                     .frame(maxWidth: .infinity, alignment: .leading)
                 }
                 
                 if tapped {
                     ZStack {
                         Color(.white)
                         VStack(spacing: 0) {
                             ForEach(0..<thisGroup.count) { i in
                                 HStack {
                                     if !thisGroup[i].profileExist {
                                         Image("defaultProfile")
                                             .resizable()
                                             .aspectRatio(contentMode: .fit)
                                             .clipShape(Circle())
                                             .frame(width: 40.0, height: 40.0)
                                     } else {
                                         Image(uiImage: thisGroup[i].profileImage)
                                             .resizable()
                                             .aspectRatio(contentMode: .fit)
                                             .clipShape(Circle())
                                             .frame(width: 40.0, height: 40.0)
                                     }
                                     Text(thisGroup[i].nickname)
                                         .padding(.horizontal)
                                         .font(.system(size: 18))
                                         .lineLimit(1)
                                     Spacer()
                                 }
                                 .padding()
                                 .frame(maxWidth: .infinity, alignment: .leading)
                                 Divider()
                             }
                         }
                     }
                 }
                 
             }
         }
     }
 }


