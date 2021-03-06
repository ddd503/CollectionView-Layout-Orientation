//
//  ViewController.swift
//  CollectionView-Layout-Orientation
//
//  Created by kawaharadai on 2019/02/09.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit
import Photos

final class ViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.register(PhotoCell.nib(), forCellWithReuseIdentifier: PhotoCell.identifier)
        }
    }

    var assets: PHFetchResult<PHAsset> = PHFetchResult() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        switch (PhotosDataStore.needsToRequestAccess(), PhotosDataStore.canAccess()) {
        case (true, _):
            PhotosDataStore.requestAuthorization { [weak self] (success) in
                self?.assets = PhotosDataStore.requestAssets()
            }
        case (_, true):
            assets = PhotosDataStore.requestAssets()
        case (_, false):
            // status is restricted or denied
            fatalError("have no permission")
        }
    }

}

extension ViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assets.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else { fatalError() }
        cell.setPhotoImage(asset: assets[indexPath.item])
        return cell
    }

}
