//
//  SelectStatusView.swift
//  chatice-ios
//
//  Created by admin on 3/3/22.
//

import SwiftUI

struct ChangeStatusMessageView: View {
    @ObservedObject var userModel: UserProfileViewModel
    @Binding var openChangeStatusMessage: Bool
    
    var body: some View {
        VStack {
            ForEach(0..<K.StatusMessage.messages.count) { i in
                HStack {
                    ForEach(0..<K.StatusMessage.messages[i].count) { j in
                        Button(action: {
                            userModel.changeAndLoadStatusMessage(selectedStatusMessage: K.StatusMessage.messages[i][j])
                            openChangeStatusMessage = false
                        }) {
                            ZStack {
                                Capsule()
                                    .fill(Color.white)
                                    .frame(height: 30)
                                Text(K.StatusMessage.messages[i][j])
                            }
                        }
                    }
                }
            }
        }
    }
}

