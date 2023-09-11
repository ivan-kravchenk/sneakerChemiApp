//
//  ProfileTab.swift
//  SneackerChemi
//
//  Created by Tribuna_159 on 05.09.2023.
//

import SwiftUI

struct ProfileTab: View {
    @State private var email = ""
    @State private var password = ""
    @State private var passwordRepeat = ""
    @State private var isShowAlert = false
    @State private var alertMessage = "Помилка"
    
    @State private var isAuthorization = true
    
    
    var body: some View {
        ZStack {
            backgroundGradient
            VStack{
                VStack{
                    Text("З поверненням!")
                        .font(.title)
                        .foregroundColor(Color.gray)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                    
                    HStack {
                        Button(action: {}) {
                            Image("appleIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.gray)
                                .frame(width: 37, height: 37)
                        }.softButtonStyle(Circle())
                            .padding(.horizontal, 15)
                        
                        Button(action: {}) {
                            Image("fbIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.gray)
                                .frame(width: 35, height: 35)
                        }.softButtonStyle(Circle())
                            .padding(.horizontal, 15)
                        
                        Button(action: {}) {
                            Image("googleIcon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 35, height: 35)
                                .foregroundColor(Color.gray)
                        }.softButtonStyle(Circle())
                            .padding(.horizontal, 15)
                        
                    }
                    
                    VStack {
                        TextField("Твій Email", text: $email).foregroundColor(Color.Neumorphic.secondary)
                            .frame(width: 300, height: 30)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16).fill(Color.Neumorphic.main)
                                    .softInnerShadow(RoundedRectangle(cornerRadius: 16), darkShadow: Color.Neumorphic.darkShadow, lightShadow: Color.Neumorphic.lightShadow, spread: 0.05, radius: 2)
                            )
                        
                        SecureField("Твій Password", text: $password).foregroundColor(Color.Neumorphic.secondary)
                            .frame(width: 300, height: 30)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 16).fill(Color.Neumorphic.main)
                                    .softInnerShadow(RoundedRectangle(cornerRadius: 16), darkShadow: Color.Neumorphic.darkShadow, lightShadow: Color.Neumorphic.lightShadow, spread: 0.05, radius: 2)
                            )
                        if !isAuthorization{
                            SecureField("Повтори Password", text: $passwordRepeat).foregroundColor(Color.Neumorphic.secondary)
                                .frame(width: 300, height: 30)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 16).fill(Color.Neumorphic.main)
                                        .softInnerShadow(RoundedRectangle(cornerRadius: 16), darkShadow: Color.Neumorphic.darkShadow, lightShadow: Color.Neumorphic.lightShadow, spread: 0.05, radius: 2)
                                )
                        }
                    }
                    .padding()
                    
                    if isAuthorization {
                        Button(action: {
                            AuthService.shared.signIn(email: self.email,
                                                      password: self.password) {result in
                                switch result {
                                case .success(let user):
                                    self.email = ""
                                    self.password = ""
                                case .failure(let error):
                                    print(error.localizedDescription, "!!!!!!!!!!!!!!!!!!!!")
                                }
                            }
                        }) {
                            Text("Увійти").fontWeight(.bold)
//                                .padding(.horizontal, 50)
                                .frame(width: 200)
                        }
                        .softButtonStyle(RoundedRectangle(cornerRadius: 16))
                        .padding()
                    }else{
                        Button(action: {
                            AuthService.shared.signUp(email: self.email,
                                                      password: self.password) {result in
                                switch result {
                                case .success(let user):
                                    self.email = ""
                                    self.password = ""
                                    self.passwordRepeat = ""
                                case .failure(let error):
                                    print(error.localizedDescription, "!!!!!!!!!!!!!!!!!!!!")
                                }
                                
                            }
                        }) {
                            Text("Зареєструватись").fontWeight(.bold)
//                                .padding(.horizontal, 50)
                                .frame(width: 200)
                        }
                        .softButtonStyle(RoundedRectangle(cornerRadius: 16))
                        .padding()
                    }
                    
                    
                    if isAuthorization {
                        HStack {
                            Text("Вперше тут?")
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                                .fontWeight(.bold)
                            
                            Button(action: {isAuthorization.toggle()}) {
                                Text("Реєструйся!")
                                    .font(.subheadline)
                                    .foregroundColor(Color.secondary)
                                    .fontWeight(.bold)
                            }
                        }
                    }else{
                        HStack {
                            Text("Маєш аккаунт?")
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                                .fontWeight(.bold)
                            
                            Button(action: {isAuthorization.toggle()}) {
                                Text("Увійди!")
                                    .font(.subheadline)
                                    .foregroundColor(Color.secondary)
                                    .fontWeight(.bold)
                            }
                        }
                    }
                }
                .padding(.vertical, 30)
                .frame(width: .infinity, height: .infinity)
                .background(backgroundGradient)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .softOuterShadow()
            }
            .padding()
            .animation(Animation.easeInOut(duration: 0.3), value: isAuthorization)
        }
        .ignoresSafeArea()
    }
}

struct ProfileTab_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTab()
    }
}
