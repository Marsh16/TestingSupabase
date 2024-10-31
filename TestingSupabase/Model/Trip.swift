//
//  Trip.swift
//  TestingSupabase
//
//  Created by Marsha Likorawung on 31/10/24.
//

import Foundation

struct Trip: Identifiable, Codable {
    var id : UUID
    var name: String
    var total: Double
    var startDate: Date
    var endDate: Date
    var user_id: UUID
//    var user: [User]
//    var bill: [Bill]
}
