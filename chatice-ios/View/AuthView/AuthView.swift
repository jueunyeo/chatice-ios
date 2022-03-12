//
//  RegisterView.swift
//  chatice-ios
//
//  Created by admin on 2/23/22.
//

import SwiftUI

struct AuthView: View {
    @ObservedObject var authModel: AuthViewModel = AuthViewModel()
    @State private var isAuth: Bool = false
    @State private var phoneText: String = ""
    @State private var nickname: String = ""
    @State private var code: String = ""
    
    var body: some View {
        VStack(spacing: 30) {
            ZStack {
                RoundedRectangle(cornerRadius: 50)
                    .fill(Color(.systemGray5))
                    .frame(height: 50)
                TextField("전화번호 (-없이 입력)", text: $phoneText)
                    .keyboardType(.numberPad)
                    .padding()
                    .onTapGesture {
                        hideKeyboard()
                    }
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 55)
                    .fill(phoneText.count > 0 ? Color(.systemBlue) : Color(.systemGray5))
                    .frame(height: 55)
                Text("인증번호 보내기")
                    .foregroundColor(Color.white)
                    .padding()
            }
            .onTapGesture {
                if phoneText.count > 0 {
                    //phoneText.remove(at: phoneText.startIndex)
                    //let formattedPhoneText = "+82" + phoneText
                    let formattedPhoneText = "+1" + phoneText
                    print(formattedPhoneText)
                    authModel.sendCode(phoneNumber: formattedPhoneText)
                }
            }
            
            if authModel.isCodeSent {
                ZStack {
                    RoundedRectangle(cornerRadius: 55)
                        .fill(Color(.systemGray5))
                        .frame(height: 55)
                    TextField("인증번호(6자리)", text: $code)
                        .keyboardType(.numberPad)
                        .padding()
                        .onTapGesture {
                            hideKeyboard()
                        }
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 55)
                        .fill(code.count == 6 ? Color(.systemBlue) : Color(.systemGray5))
                        .frame(height: 55)
                    Text("인증번호 확인")
                        .foregroundColor(Color.white)
                        .padding()
                }
                .onTapGesture {
                    if code.count == 6 {
                        print(code)
                        authModel.verifyCode(code: code)
                    }
                }
            }
            
            if authModel.isVerified && authModel.isRegistered {
                //existing user
                Button(action : {
                    isAuth = true
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color(.systemBlue))
                            .frame(height: 50)
                        Text("\(authModel.userNickname)(으)로 시작하기")
                            .foregroundColor(Color.white)
                            .padding()
                    }
                    .fullScreenCover(isPresented: $isAuth, content: {
                        MainView()
                    })
                }
                
            }
            
            if authModel.isVerified && !authModel.isRegistered {
                //new user
                ZStack {
                    RoundedRectangle(cornerRadius: 55)
                        .fill(Color(.systemGray5))
                        .frame(height: 55)
                    TextField("사용자 이름", text: $nickname)
                        .padding()
                        .onTapGesture {
                            hideKeyboard()
                        }
                }
                ZStack {
                    RoundedRectangle(cornerRadius: 55)
                        .fill(nickname.count > 0 ? Color(.systemBlue) : Color(.systemGray5))
                        .frame(height: 55)
                    Text("인증번호 확인")
                        .foregroundColor(Color.white)
                        .padding()
                }
                .onTapGesture {
                    if nickname.count > 0 {
                        print(code)
                        authModel.createUserInfo(newNickname: nickname)
                    }
                }
            }
            
            
            
            
            
            
            
        }
        .frame(width: 300)
    }
}

