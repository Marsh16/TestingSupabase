import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var signInStatus: SignInStatus
    
    var body: some View {
        VStack {
            Text("Welcome!")
            
            Button {
                Task {
                    try await AuthManager.shared.logoutFromApple()
                    signInStatus.signedIn = false
                    
                    // AuthManager.shared.client.auth.session.user
                }
            } label: {
                Text("Logout")
            }


        }
    }
}

#Preview {
    HomeView()
}
