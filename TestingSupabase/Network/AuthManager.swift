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
    
    private init(){}
    
    let client = SupabaseClient(
        supabaseURL: URL(string: "https://xufihalpveypjyaowpnu.supabase.co")!,
        supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh1ZmloYWxwdmV5cGp5YW93cG51Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzAwODIwNjQsImV4cCI6MjA0NTY1ODA2NH0.6mr6UwIN9SCVKq1ZSs8ufsIJC_cIHDxIRFcSJX5J45c"
      )
    
    func signInWithApple(idToken: String, nonce: String) async throws {
        let credentials = OpenIDConnectCredentials(provider: .apple, idToken: idToken, nonce: nonce)
        try await client.auth.signInWithIdToken(credentials: credentials)
    }
}
