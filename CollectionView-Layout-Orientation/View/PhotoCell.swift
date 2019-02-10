//
//  PhotoCell.swift
//  CollectionView-Layout-Orientation
//
//  Created by kawaharadai on 2019/02/10.
//  Copyright © 2019 kawaharadai. All rights reserved.
//

import UIKit
import Photos

final class PhotoCell: UICollectionViewCell {

    @IBOutlet private weak var imageView: UIImageView!

    static var identifier: String {
        return String(describing: self)
    }

    static func nib() -> UINib {
        return UINib(nibName: identifier, bundle: nil)
    }

    private let options = { () -> PHImageRequestOptions in
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.resizeMode = .exact
        options.version = .original
        return options
    }()
    
    private func itemSize() -> CGSize {
        let screenWidth = UIScreen.main.bounds.size.width
        let itemLength = UIApplication.shared.statusBarOrientation.isLandscape ?
            (screenWidth - CGFloat(hasSafeArea() ? 88 : 0)) / 8 - 1 : screenWidth / 4 - 1
        return CGSize(width: itemLength, height: itemLength)
    }

    private func hasSafeArea() -> Bool {
        let insets = UIApplication.shared.keyWindow?.safeAreaInsets ?? UIEdgeInsets.zero
        return ((insets.top > 0) && (insets.bottom > 0)) || ((insets.left > 0) && (insets.right > 0))
    }

    func setPhotoImage(asset: PHAsset) {
        PHCachingImageManager.default().requestImage(for: asset, targetSize: itemSize(), contentMode: .aspectFit, options: options) { [weak self] (image, dic) in
            self?.imageView.image = image
        }
    }

}
