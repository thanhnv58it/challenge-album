//
//  URLs.swift
//  My Album
//
//  Created by Thành Ngô Văn on 16/02/2022.
//

import Foundation

struct URLs {
    static let DOMAIN = "http://jsonplaceholder.typicode.com/"

    enum Path: String {
        case getAlbums = "albums"
        case getUsers = "users"
        case getPhotos = "photos"
    }
}
    


