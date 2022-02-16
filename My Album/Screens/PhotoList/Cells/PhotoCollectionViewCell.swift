//
//  PhotoCollectionViewCell.swift
//  My Album
//
//  Created by Thành Ngô Văn on 16/02/2022.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgThumbnail: UIImageView!

    func fillData(photo: PhotoModel) {
        let url = URL(string: photo.thumbnailURL)
        imgThumbnail.kf.setImage(with: url)
    }
}
