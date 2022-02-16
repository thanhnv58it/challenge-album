//
//  RequestInputBase.swift
//  My Album
//
//  Created by Thành Ngô Văn on 16/02/2022.
//

import Foundation

protocol RequestInputBase {
    var path: String {get}
}

extension RequestInputBase {
    var getURL: String {
        return URLs.DOMAIN + path
    }
}
