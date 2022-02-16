//
//  AlbumModel.swift
//  My Album
//
//  Created by Thành Ngô Văn on 16/02/2022.
//

import Foundation

class AlbumModel: Codable {
    let userID, id: Int
    let title: String
    var userName: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title
    }
}
