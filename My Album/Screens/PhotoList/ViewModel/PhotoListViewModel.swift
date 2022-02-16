//
//  PhotoListViewModel.swift
//  My Album
//
//  Created by Thành Ngô Văn on 16/02/2022.
//

import Foundation
import RxSwift
import RxRelay

class PhotoListViewModel {

    let relayPhotos = BehaviorRelay<[PhotoModel]>(value: [])

    init(photos: [PhotoModel]) {
        self.relayPhotos.accept(photos)
    }
}
