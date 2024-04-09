//
//  UserModel.swift
//  ClosureToAsyncAwait
//
//  Created by Ayush Gupta on 09/04/24.
//

import Foundation

struct UserModel: Codable {
    let id: Int?
    let login: String?
    let nodeID: String?
    let avatarURL: String?
    let gravatarID: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
    }
}
