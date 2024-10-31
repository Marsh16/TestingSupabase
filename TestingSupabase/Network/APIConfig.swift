//
//  apicONFIG.swift
//  TestingSupabase
//
//  Created by Marsha Likorawung on 30/10/24.
//

import Foundation

protocol APIConfigurable {
    var supabaseURL: String { get }
    var supabaseKey: String { get }
}

class APIConfig: APIConfigurable, ObservableObject {
    let supabaseURL: String
    let supabaseKey: String
    
    init() {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let config = NSDictionary(contentsOfFile: path) as? [String: Any] else {
            fatalError("Couldn't find Config.plist file or it is not in correct format")
        }
        
        guard let supabaseURL = config["supabaseURL"] as? String, !supabaseURL.isEmpty,
              let supabaseKey = config["supabaseKey"] as? String, !supabaseKey.isEmpty
        else {
            fatalError("One or more keys are missing or empty in Config.plist")
        }
        
        self.supabaseURL = supabaseURL
        self.supabaseKey = supabaseKey
    }
}
