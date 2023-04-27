//
//  ListsCollectionDelegate.swift
//  FlashSpeak
//
//  Created by Denis Dmitriev on 20.04.2023.
//
// swiftlint:disable line_length

import UIKit

class ListsCollectionDelegate: NSObject, UICollectionViewDelegate {
    
    weak var viewController: (UIViewController & ListsViewInput)?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewController?.didSelectList(indexPath: indexPath)
    }
}

extension ListsCollectionDelegate: UICollectionViewDelegateFlowLayout {
    
    enum Settings {
        static let itemPerRow: CGFloat = 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layoutWith = Layout.insetsCollection.left + Layout.insetsCollection.right
        let fullWidth = (viewController?.view.frame.width ?? UIScreen.main.bounds.width) - layoutWith
        let width = (fullWidth - (Settings.itemPerRow - 1) * Layout.separatorCollection ) / Settings.itemPerRow
        let height: CGFloat = Grid.pt128
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Layout.separatorCollection
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Layout.separatorCollection
    }
}

// swiftlint:enable line_length
