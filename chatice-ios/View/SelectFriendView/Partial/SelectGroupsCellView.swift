//
//  SelectGroupsCellView.swift
//  chatice-ios
//
//  Created by admin on 3/3/22.
//

import SwiftUI

struct SelectGroupsCellView: View {
    @Binding var selected: [String]
    let groupTitle: String
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(groupTitle)
                    .padding(.horizontal)
                    .font(.system(size: 18))
                Spacer()
                Image(systemName: selected.contains(groupTitle) ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25.0, height: 25.0)
                    .foregroundColor(selected.contains(groupTitle) ? Color(.systemBlue) : Color.secondary)
                    .onTapGesture {
                        if selected.contains(groupTitle) {
                            if let index = selected.firstIndex(of: groupTitle) {
                                selected.remove(at: index)
                            }
                        } else {
                            selected.append(groupTitle)
                        }
                    }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

