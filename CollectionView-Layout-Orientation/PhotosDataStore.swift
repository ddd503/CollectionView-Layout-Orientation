//
//  PhotosDataStore.swift
//  CollectionView-Layout-Orientation
//
//  Created by kawaharadai on 2019/02/09.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import Photos

final class PhotosDataStore {
    static func requestAssets() -> PHFetchResult<PHAsset> {
        let options = PHFetchOptions()
        options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        return PHAsset.fetchAssets(with: .image, options: options)
    }
}
