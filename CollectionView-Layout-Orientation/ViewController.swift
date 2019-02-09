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

    var assets: PHFetchResult<PHAsset> = PHFetchResult()

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        return cell
    }

}
