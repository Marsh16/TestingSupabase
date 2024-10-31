//
//  Bill.swift
//  TestingSupabase
//
//  Created by Marsha Likorawung on 31/10/24.
//

import Foundation

struct Bill: Identifiable, Codable {
    var id : UUID
    var name: String
    var discount: Double
    var currency: String
    var total: Double
    var item: [Item]
    var payer: String
    var bank: String
    var accountName: String
    var accountNo: String
    var isPaid: Bool
    var trip: Trip
}
