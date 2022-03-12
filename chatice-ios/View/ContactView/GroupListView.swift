//
//  GroupListView.swift
//  chatice-ios
//
//  Created by admin on 2/21/22.
//

import SwiftUI

struct GroupListView: View {
    @ObservedObject var friendGroupModel: FriendGroupViewModel = FriendGroupViewModel()
    
    @State private var tapped: Bool = false
    @State private var showingDeleteAlert = false
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    if !friendGroupModel.friendGroup.isEmpty {
                        ForEach(friendGroupModel.friendGroup.keys.sorted(), id: \.self) { key in
                            GroupCellView(friendGroupModel: friendGroupModel, groupTitle: key)
                        }
                    }
                }
            }.onAppear {
                friendGroupModel.loadFriendGroup()
            }
        }
    }
}

