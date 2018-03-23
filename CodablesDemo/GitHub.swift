//
//  GitHub.swift
//  CodablesDemo
//
//  Created by Appinventiv on 22/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

struct GitHub: Codable {
    
    let avatarUrl: URL?
    let company : String?
    let followers: Int?
    let location: String?
    let login: String?
    let name: String?
    let repos: Int?
    
    private enum CodingKeys: String, CodingKey {
        
       case avatarUrl = "avatar_url"
        case company
        case followers
        case location
        case login
        case name
        case repos = "public_repos"
       
    }
}
