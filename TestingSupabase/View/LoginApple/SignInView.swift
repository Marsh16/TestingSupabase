//
//  SignInView.swift
//  TestingSupabase
//
//  Created by Marsha Likorawung on 30/10/24.
//


import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @EnvironmentObject var signInStatus: SignInStatus
    let signInApple = SignInAppleUtils()
    
    var body: some View {
        VStack {
            Button {
                signInApple.startSignInWithAppleFlow { result in
                    switch result {
                    case .success(let appleResult):
                        Task {
                            try await AuthManager.shared.signInWithApple(idToken: appleResult.idToken, nonce: appleResult.nonce)
                            signInStatus.signedIn = true
                        }
                    case .failure(_):
                        print("error")
                    }
                }
            } label: {
                SignInWithAppleButton(onRequest: {_ in }, onCompletion: {_ in }).fixedSize()
            }
        }
    }
}

#Preview {
    SignInView()
}

