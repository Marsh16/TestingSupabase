//
//  User.swift
//  TestingSupabase
//
//  Created by Marsha Likorawung on 30/10/24.
//

import Foundation

struct User: Identifiable, Codable {
    var id: UUID
    var updated_at: Date
    var email: String
//    var phone_number : String
//    var name: String
}
