//
//  AuthManager.swift
//  TestingSupabase
//
//  Created by Marsha Likorawung on 30/10/24.
//

import Foundation
import Supabase

class AuthManager {
    static let shared = AuthManager()
    private let config: APIConfigurable

    init(config: APIConfigurable = APIConfig()) {
        self.config = config
    }

    lazy var client = SupabaseClient(
        supabaseURL: URL(string: config.supabaseURL)!,
        supabaseKey: config.supabaseKey
    )

    func signInWithApple(idToken: String, nonce: String) async throws {
        let credentials = OpenIDConnectCredentials(provider: .apple, idToken: idToken, nonce: nonce)
        try await client.auth.signInWithIdToken(credentials: credentials)
    }
}
