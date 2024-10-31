//
//  Item.swift
//  TestingSupabase
//
//  Created by Marsha Likorawung on 31/10/24.
//
import Foundation

struct Item: Identifiable, Codable {
    var id : UUID
    var quantity: Int
    var name: String
    var price: Double
    var user: [User]
    var discount: Double
}
