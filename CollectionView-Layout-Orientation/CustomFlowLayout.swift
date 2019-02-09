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
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1
        itemSize = itemSize()
        guard hasSafeArea() else { return }
        adjustSafeArea()
    }

    private let safeAreaInsets = {
        return UIApplication.shared.keyWindow?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }()

    private func hasSafeArea() -> Bool {
        return ((safeAreaInsets.top > 0) && (safeAreaInsets.bottom > 0)) || ((safeAreaInsets.left > 0) && (safeAreaInsets.right > 0))
    }

    private func itemSize() -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let itemLength = UIApplication.shared.statusBarOrientation.isLandscape ?
            (screenWidth - (hasSafeArea() ? max(safeAreaInsets.top, safeAreaInsets.left, safeAreaInsets.right) : 0)) / 6 - 1 : screenWidth / 3 - 1
        return CGSize(width: itemLength, height: itemLength)
    }

    private func adjustSafeArea() {
        let sideInsets = sideInsetAsSafeArea()
        sectionInset.left = sideInsets.leftInset
        sectionInset.right = sideInsets.rightInset
    }

    private func sideInsetAsSafeArea() -> (leftInset: CGFloat, rightInset: CGFloat) {
        let insets = safeAreaInsets
        switch UIApplication.shared.statusBarOrientation {
        case .landscapeLeft:
            return (0, max(insets.top, insets.left))
        case .landscapeRight:
            return (max(insets.top, insets.right), 0)
        default:
            return (0, 0)
        }
    }

}

