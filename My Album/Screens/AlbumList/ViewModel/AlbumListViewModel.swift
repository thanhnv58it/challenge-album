//
//  AlbumListViewModel.swift
//  My Album
//
//  Created by Thành Ngô Văn on 16/02/2022.
//

import Foundation
import RxSwift
import RxRelay

class AlbumListViewModel {
        
    let relayLoading = BehaviorRelay<Bool>(value: false)
    let relayError = BehaviorSubject<String?>(value: nil)
    let relayAlbumList = BehaviorRelay<[AlbumModel]>(value: [])

    private let disposeBag = DisposeBag()
    private var photos: [PhotoModel]? = nil
    
    init() {
        getAlbums()
    }
    
    private func getAlbums() {
        relayLoading.accept(true)
        let getAlbumInput = GetAlbumRequest()
        let albumsObs = Request.sendRequest(input: getAlbumInput, outputType: [AlbumModel].self)
        
        let getUserInput = GetUserRequest()
        let userObs = Request.sendRequest(input: getUserInput, outputType: [UserModel].self)
        
        Observable.zip(albumsObs, userObs).subscribe(onNext: { [weak self] (albums, users) in
            self?.relayLoading.accept(false)
            guard let albums = albums else {
                return
            }
            albums.forEach({ album in
                let user = users?.first(where: {$0.id == album.userID})
                album.userName = user?.name
            })
            self?.relayAlbumList.accept(albums)

        }, onError: { [weak self] error in
            self?.relayLoading.accept(false)
            self?.relayError.onNext(error.localizedDescription)
        }).disposed(by: disposeBag)
        
    }
    
    func getPhotos(album id: Int, complete: @escaping ([PhotoModel]) -> Void) {
        if let photos = photos {
            let filtered = filterPhoto(photos: photos, id: id)
            complete(filtered)
        } else {
            getPhotos { [weak self] in
                self?.getPhotos(album: id, complete: complete)
            }
        }
    }
    
    private func filterPhoto(photos: [PhotoModel], id: Int) -> [PhotoModel] {
        return photos.filter{$0.albumID == id}
    }
    
    private func getPhotos(complete: @escaping () -> Void) {
        relayLoading.accept(true)

        let input = GetPhotoRequest()
        Request.sendRequest(input: input, outputType: [PhotoModel].self).subscribe { [weak self] (photos) in
            self?.relayLoading.accept(false)
            self?.photos = photos ?? []
            complete()
        } onError: { [weak self] (error) in
            self?.relayLoading.accept(false)
            self?.relayError.onNext(error.localizedDescription)
        }.disposed(by: disposeBag)

    }
}
