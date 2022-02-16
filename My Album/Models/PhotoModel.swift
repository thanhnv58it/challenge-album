//
//  PhotoModel.swift
//  My Album
//
//  Created by Thành Ngô Văn on 16/02/2022.
//

import Foundation

struct PhotoModel: Codable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
