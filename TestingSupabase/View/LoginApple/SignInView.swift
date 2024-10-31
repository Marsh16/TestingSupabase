import SwiftUI
import AuthenticationServices
import Supabase

struct SignInView: View {
    let client = SupabaseClient(supabaseURL: URL(string: "your url")!, supabaseKey: "your anon key")

    var body: some View {
      SignInWithAppleButton { request in
        request.requestedScopes = [.email, .fullName]
      } onCompletion: { result in
        Task {
          do {
            guard let credential = try result.get().credential as? ASAuthorizationAppleIDCredential
            else {
              return
            }

            guard let idToken = credential.identityToken
              .flatMap({ String(data: $0, encoding: .utf8) })
            else {
              return
            }
              try await client.auth.signInWithIdToken(
              credentials: .init(
                provider: .apple,
                idToken: idToken
              )
            )
          } catch {
            dump(error)
          }
        }
      }
      .fixedSize()
    }
}
