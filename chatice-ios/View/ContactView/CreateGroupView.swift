//
//  CreateGroupView.swift
//  chatice-ios
//
//  Created by admin on 2/28/22.
//

import SwiftUI

struct CreateGroupView: View {
    @Binding var openCreateGroup: Bool
    @State var selected: [String] = []
    @State var groupTitle: String = ""
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "xmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 17.0, height: 17.0)
                    .padding(20)
                    .foregroundColor(Color(.systemBlue))
                    .onTapGesture {
                        openCreateGroup = false
                    }
                Spacer()
                if selected.count > 1 {
                    Text("만들기")
                        .foregroundColor(Color(.systemBlue))
                        .padding(20)
                        .onTapGesture {
                            let alertHC = UIHostingController(rootView: CreateGroupTextAlert(openCreateGroup: $openCreateGroup, groupMembers: selected))

                            alertHC.preferredContentSize = CGSize(width: 300, height: 200)
                            alertHC.modalPresentationStyle = UIModalPresentationStyle.formSheet

                            UIApplication.shared.windows[0].rootViewController?.present(alertHC, animated: true)
                        }
                } else {
                    Text("만들기")
                        .foregroundColor(Color.secondary)
                        .padding(20)
                }
                
            }
            HStack {
                Text("그룹 만들기")
                    .font(.system(size: 28, weight: .bold))
                    .padding()
                Spacer()
            }
            
            SelectFriendsListView(selected: $selected)
            
            Spacer()
        }
    }
}

