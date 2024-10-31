//
//  UserTrip.swift
//  TestingSupabase
//
//  Created by Marsha Likorawung on 31/10/24.
//

import Foundation

struct UserTrip: Identifiable, Codable {
    var id: UUID
    var tripId: UUID
    var userId: UUID
}
