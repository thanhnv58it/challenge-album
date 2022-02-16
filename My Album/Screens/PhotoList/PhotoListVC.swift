//
//  PhotoListVC.swift
//  My Album
//
//  Created by Thành Ngô Văn on 16/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

class PhotoListVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: PhotoListViewModel!
    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        setupCollectionView()
        bindRx()
    }

    private func setupCollectionView() {
        collectionView.register(PhotoCollectionViewCell.nib, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func imageTapped(_ photo: PhotoModel) {
        let imageView = UIImageView(frame: UIScreen.main.bounds)
        imageView.backgroundColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        imageView.addGestureRecognizer(tap)
        self.view.addSubview(imageView)
        self.navigationController?.isNavigationBarHidden = true
        
        let url = URL(string: photo.url)
        imageView.kf.setImage(with: url)
    }

    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        sender.view?.removeFromSuperview()
    }
}

extension PhotoListVC {
    
    func bindRx() {
        viewModel.relayPhotos.bind(to: collectionView.rx.items(cellIdentifier: PhotoCollectionViewCell.identifier, cellType: PhotoCollectionViewCell.self)) { (row, element, cell) in
            cell.fillData(photo: element)
         }
         .disposed(by: disposeBag)
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        collectionView.rx.itemSelected.bind { [weak self] indexPath in
            guard let self = self else { return }
            let photo = self.viewModel.relayPhotos.value[indexPath.row]
            self.imageTapped(photo)
        }.disposed(by: disposeBag)
    }
}

extension PhotoListVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = 3
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }
}
