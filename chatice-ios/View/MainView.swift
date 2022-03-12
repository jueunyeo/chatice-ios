//
//  MainView.swift
//  chatice-ios
//
//  Created by admin on 2/21/22.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        ZStack {
            TabView {
                ContactTabView()
                    .tabItem {
                        Image(systemName: "person.3.fill")
                        Text("친구")
                    }
                    
                /*
                ChatFrameView(chatListViewModel: chatListViewModel, groupChatListViewModel: groupChatListViewModel)
                    .tabItem {
                        Image(systemName: "bubble.left.and.bubble.right.fill")
                        Text("채팅")
                    }
                    .badge("Label")
                
                
                AlarmMsgFrameView()
                    .tabItem{
                        Image(systemName: "bell.fill")
                        Text("알림메시지")
                    }
                
                ShortNoteFrameView(shortNoteInListViewModel: shortNoteInListViewModel, shortNoteOutListViewModel: shortNoteOutListViewModel)
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("숏노트")
                    }
                    .badge("Label")
                
                MyView()
                 .tabItem {
                     Image(systemName: "person.fill")
                     Text("내 페이지")
                 }
                 */
            }
            .accentColor(.black)
        }
    }
}

