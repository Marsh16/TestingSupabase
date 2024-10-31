//
//  SignInStatus.swift
//  TestingSupabase
//
//  Created by Marsha Likorawung on 30/10/24.
//
import OneSignalFramework
import SwiftUI

class SignInStatus: ObservableObject {
    let signInApple = SignInAppleUtils()
    @Published var signedIn: Bool = false
    @Published var user :  User = User(id: UUID(), updated_at: Date(), email: "")
    @Published var trip :  Trip = Trip(id: UUID(), name: "", total: 0.0, startDate: Date(), endDate: Date(), user_id: UUID())
    
    func logoutFromApple() async throws {
        try await AuthManager.shared.client.auth.signOut()
    }
    
    func addTrip(_ trip: Trip) async throws {
        print("masuk")
        let result = try await AuthManager.shared.client
            .from("trip")
            .insert(trip)
            .execute()
        print(result)
        self.trip = trip
    }
    
    func getUsers() async throws -> [User]{
        let user: [User] = try await AuthManager.shared.client
            .from("users")
            .select()
            .execute()
            .value
        return user
    }
    
    @MainActor
    func getCurrentSession() async throws {
        let auth = try await AuthManager.shared.client.auth.session.user
        user = User(id: auth.id, updated_at: auth.updatedAt, email: auth.email!)
        if (!user.id.uuidString.isEmpty) {
            // timenya format gini 2024-10-31 20:54:00 GMT+0700
            OneSignal.login(externalId: user.id.uuidString.lowercased(), token: "")
         }
        try await checkUserExist()
    }
    
    func checkUserExist() async throws {
        let listUsers = try await getUsers()
        
        for existingUser in listUsers {
            if existingUser.email == user.email {
                print("A user with the email address '\(user.email)' already exists.")
            }else{
                try await addUser(user)
            }
        }
    }

    func addUser(_ user: User) async throws {
        try await AuthManager.shared.client
            .from("users")
            .insert(user)
            .execute()
    }
    
    func editUser(_ user: User) async throws {
        try await AuthManager.shared.client
            .from("users")
            .update(["email": user.email])
            .eq("id", value: user.id)
            .execute()
    }
    
    func deleteUser(_ user: User) async throws {
        try await AuthManager.shared.client
            .from("users")
            .delete()
            .eq("id", value: user.id)
            .execute()
    }
}
