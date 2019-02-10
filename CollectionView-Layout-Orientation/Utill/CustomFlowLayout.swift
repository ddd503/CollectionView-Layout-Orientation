//
//  CustomFlowLayout.swift
//  CollectionView-Layout-Orientation
//
//  Created by kawaharadai on 2019/02/10.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit

final class CustomFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        itemSize = itemSize()
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1
        sectionInsetReference = .fromSafeArea
    }

    private func itemSize() -> CGSize {
        guard let cv = collectionView else { return CGSize.zero }
        let itemLength = UIApplication.shared.statusBarOrientation.isLandscape ?
            cv.bounds.width / 8 - 1 : cv.bounds.width / 4 - 1
        return CGSize(width: itemLength, height: itemLength)
    }

}

