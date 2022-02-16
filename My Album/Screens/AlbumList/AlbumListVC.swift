//
//  AlbumListVC.swift
//  My Album
//
//  Created by Thành Ngô Văn on 16/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

class AlbumListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = AlbumListViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindRx()
        title = "Albums"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
    
    private func showAlbumDetails(title: String, photos: [PhotoModel]) {
        let photo = PhotoListVC(nibName: PhotoListVC.nibName, bundle: nil)
        photo.title = title
        photo.viewModel = PhotoListViewModel(photos: photos)
        navigationController?.pushViewController(photo, animated: true)
    }
}

extension AlbumListVC {
    
    func bindRx() {
        
        viewModel.relayLoading.bind { [weak self] (isLoading) in
            guard let self = self else { return }
            isLoading ? self.showLoading() : self.hideLoading()
        }.disposed(by: disposeBag)
                
        viewModel.relayAlbumList.bind(to: tableView.rx.items) { (tableView, row, element) in
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
            cell.textLabel?.text = element.title
            cell.textLabel?.numberOfLines = 0
            cell.detailTextLabel?.text = element.userName
            cell.accessoryType = .disclosureIndicator
            cell.selectionStyle = .none
            return cell
        }
        .disposed(by: disposeBag)
        
        viewModel.relayError.bind { [weak self] (message) in
            guard let self = self, let message = message else {
                return
            }
            self.showError(message: message)
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.bind { [weak self] (indexPath) in
            guard let self = self else { return }
            let album = self.viewModel.relayAlbumList.value[indexPath.row]
            self.viewModel.getPhotos(album: album.id) { [weak self] photos in
                self?.showAlbumDetails(title: album.title, photos: photos)
            }
        }.disposed(by: disposeBag)

    }
}
