//
//  TestingSupabaseApp.swift
//  TestingSupabase
//
//  Created by Marsha Likorawung on 29/10/24.
//

import SwiftUI
import OneSignalFramework

@main
struct TestingSupabaseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var signInStatus = SignInStatus()
    @State var isLoaded: Bool = false
    
    var body: some Scene {
        WindowGroup {
//            OnboardingView()
            if isLoaded {
                if signInStatus.signedIn {
                    HomeView()
                        .environmentObject(signInStatus)
                } else {
                    SignInView()
                        .environmentObject(signInStatus)
                }
            } else {
                OnboardingView()
                    .onAppear {
                        Task {
                            isLoaded = true
                            if AuthManager.shared.client.auth.currentSession != nil {
                                signInStatus.signedIn = true
                            } else {
                                signInStatus.signedIn = false
                            }
                        }
                    }
            }
                
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
       // Remove this method to stop OneSignal Debugging
       OneSignal.Debug.setLogLevel(.LL_VERBOSE)
        
       // OneSignal initialization
       OneSignal.initialize("2c7a2528-3fe5-40a1-ba91-c43c888ecd8a", withLaunchOptions: launchOptions)

       // requestPermission will show the native iOS notification permission prompt.
       // We recommend removing the following code and instead using an In-App Message to prompt for notification permission
       OneSignal.Notifications.requestPermission({ accepted in
         print("User accepted notifications: \(accepted)")
       }, fallbackToSettings: true)

       // Login your customer with externalId
       // OneSignal.login("EXTERNAL_ID")
            
       return true
    }
}
