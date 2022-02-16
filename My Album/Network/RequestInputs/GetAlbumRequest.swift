//
//  GetAlbumRequest.swift
//  My Album
//
//  Created by Thành Ngô Văn on 16/02/2022.
//

import Foundation

struct GetAlbumRequest: RequestInputBase {
    var path: String = URLs.Path.getAlbums.rawValue
}
