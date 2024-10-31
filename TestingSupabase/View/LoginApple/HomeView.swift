//
//  HomeView.swift
//  TestingSupabase
//
//  Created by Marsha Likorawung on 30/10/24.
//


import SwiftUI

struct HomeView: View {
    @EnvironmentObject var signInStatus: SignInStatus
    
    var body: some View {
        VStack {
            Text("Welcome!")
            Button{
                Task {
                    print(signInStatus.user.email)
                    let trip = Trip(id: UUID(), name: "Malang", total:  10000, startDate: Date(), endDate: Date(), user_id: signInStatus.user.id)
                    print(trip)
                    try await signInStatus.addTrip(trip)
                    print("added")
                }
            } label: {
                Text("Add Trip")
            }
            
            if !signInStatus.user.email.isEmpty {
                Text(signInStatus.user.email)
            }
            
            Button {
                Task {
                    try await signInStatus.logoutFromApple()
                    signInStatus.signedIn = false
                }
            } label: {
                Text("Logout")
            }
            
        }.onAppear{
            Task {
                try await signInStatus.getCurrentSession()
            }
        }
    }
}

#Preview {
    HomeView()
}
